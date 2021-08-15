//
//  ViewController.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 12.08.2021.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var characterList: [CharacterListResultModel] = []
    
    var viewModel: HomeViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        viewModel = HomeViewModel()
        viewModel.load()
    }
    
    func initCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width / 2
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        collectionView.registerNib("CharacterListCell")
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func handleViewModelOutput(_ output: HomeViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                Loader.show()
                return
            }
            Loader.hide()
        case .showList(let data):
            self.characterList = data
            self.collectionView.reloadData()
        }
    }
    
    func navigate(to route: HomeViewRoute) {
        switch route {
        case .detail(let item):
            let vc = HomeRouter.detail(item: item)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterListCell", for: indexPath) as? CharacterListCell {
            cell.configure(with: characterList[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == characterList.count - 1 {
            viewModel.load()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCharacter(at: indexPath.row)
    }
    
}

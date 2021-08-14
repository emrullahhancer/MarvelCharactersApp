//
//  FavoritesViewController.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let defaults = UserDefaults.standard
    let decoder = JSONDecoder()
    
    var favorites = [CharacterListResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let data = defaults.object(forKey: "FavoriteCharacters") as? Data {
            if var favorites = try? decoder.decode([CharacterListResultModel].self, from: data) {
                self.favorites = favorites
                collectionView.reloadData()
            }
        }
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

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterListCell", for: indexPath) as? CharacterListCell {
            cell.configure(with: favorites[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeRouter.detail(item: favorites[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

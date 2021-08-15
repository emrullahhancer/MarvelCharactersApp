//
//  CharacterDetailViewController.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import UIKit

protocol CharacterDetailDelegate: AnyObject {
    func favorite(item: CharacterListResultModel)
}

class CharacterDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var item: CharacterListResultModel?
    var comics = ComicsModel()
    
    var viewModel: CharacterDetailViewModel! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CharacterDetailViewModel()
        viewModel.load(characterID: "\(item?.id ?? 0)")
        initTableView()
    }
    
    func initTableView() {
        viewModel.pageComponents.append(DetailComponents(type: .detail))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerNib("ComicsCell")
    }
    
    func initComponents() {
        
        comics.data?.results?.forEach({ _ in
            self.viewModel.pageComponents.append(DetailComponents(type: .comics))
        })
        tableView.reloadData()
    }
}

extension CharacterDetailViewController: CharacterDetailViewModelDelegate {
    func handleViewModelOutput(_ output: CharacterDetailViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            if isLoading {
                Loader.show()
                return
            }
            Loader.hide()
        case .showComics(let comics):
            self.comics = comics
            self.initComponents()
        }
    }
}
extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pageComponents.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.pageComponents[indexPath.row].type {
            case .detail:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailCell", for: indexPath) as? CharacterDetailCell {
                    cell.configure(with: item)
                    cell.delegate = self
                    return cell
                }
            case .comics:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsCell", for: indexPath) as? ComicsCell {
                    cell.tag = indexPath.row
                    cell.configure(with: comics.data?.results?[indexPath.row - 1])
                    return cell
                }
            default:
                break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.pageComponents[indexPath.row].type {
            case .detail:
                return UITableView.automaticDimension
            default:
                return UIScreen.main.bounds.width * 0.53333333333
        }
        
    }
    
}

extension CharacterDetailViewController: CharacterDetailDelegate {
    func favorite(item: CharacterListResultModel) {
        
        let isFav = Utilities.isFav(item: item, remove: true)
        if !isFav {
            Utilities.appendFav(item: item)
        }
        
        self.tableView.reloadData()
    }
    
    
}

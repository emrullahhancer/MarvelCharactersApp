//
//  HomeViewModel.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    func load()
    func selectCharacter(at index: Int)
}

enum HomeViewModelOutput {
    case setLoading(Bool)
    case showList([CharacterListResultModel])
}

enum HomeViewRoute {
    case detail(CharacterListResultModel)
}

protocol HomeViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: HomeViewModelOutput)
    func navigate(to route: HomeViewRoute)
}



class HomeViewModel: HomeViewModelProtocol {
    
    var delegate: HomeViewModelDelegate?
    var offset = 0
    var list = [CharacterListResultModel]()
    
    func load() {
        notify(.setLoading(true))
        APIService.shared.getCharacters(offset: self.offset) { data in
            self.notify(.setLoading(false))
            data.data?.results?.forEach({ item in
                self.list.append(item)
            })
            self.offset += 30
            self.notify(.showList(self.list))
        } failure: { error in
            self.notify(.setLoading(false))
        }
    }
    
    func selectCharacter(at index: Int) {
        let character = list[index]
        delegate?.navigate(to: .detail(character))
    }
    
    private func notify(_ output: HomeViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
}

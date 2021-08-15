//
//  CharacterDetailViewModel.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import Foundation


enum CharacterDetailViewModelOutput {
    case setLoading(Bool)
    case showComics(ComicsModel)
}

protocol CharacterDetailViewModelDelegate: AnyObject {
    func handleViewModelOutput(_ output: CharacterDetailViewModelOutput)
}

enum DetailComponentsType {
    case detail
    case comics
}

struct DetailComponents {
    var type: DetailComponentsType?
}

class CharacterDetailViewModel {
    
    var delegate: CharacterDetailViewModelDelegate?
    
    func load(characterID: String) {
        //notify(.setLoading(true))
        APIService.shared.getComics(characterID: characterID) { data in
            //self.notify(.setLoading(false))
            
            self.notify(.showComics(data))
        } failure: { err in
            //self.notify(.setLoading(false))
        }
    }
    
    private func notify(_ output: CharacterDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
    var pageComponents = [DetailComponents]()
    
}

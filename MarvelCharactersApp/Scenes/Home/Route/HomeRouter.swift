//
//  HomeRouter.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import UIKit

final class HomeRouter {
    
    static func detail(item: CharacterListResultModel?) -> CharacterDetailViewController {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CharacterDetailViewController") as! CharacterDetailViewController
        viewController.item = item
        return viewController
    }
}

//
//  ApplicationTabbarController.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import UIKit

class ApplicationTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
    }
    
    func setTabBarItems() {
        self.tabBar.isTranslucent = false
    }

}

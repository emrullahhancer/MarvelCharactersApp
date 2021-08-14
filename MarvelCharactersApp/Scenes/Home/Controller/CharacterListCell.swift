//
//  CharacterListCell.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import UIKit
import SDWebImage

class CharacterListCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with item: CharacterListResultModel) {
        imageView.sd_setImage(with: URL(string: "\(item.thumbnail?.path?.replace(target: "http", withString: "https") ?? "").\(item.thumbnail?.thumbnailExtension ?? "")")) { image, err, cache, url in
            
        }
    }

}

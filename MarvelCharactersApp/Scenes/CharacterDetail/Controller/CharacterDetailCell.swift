//
//  CharacterDetailCell.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import UIKit
import SDWebImage

class CharacterDetailCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: CharacterDetailDelegate?
    var item: CharacterListResultModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        favoriteButton.addTarget(self, action: #selector(favoriteTap), for: .touchUpInside)
        mainImage.alpha = 0
    }

    func configure(with item: CharacterListResultModel?) {
        self.item = item
        if let item = item {
            let isFav = Utilities.isFav(item: item)
            self.favoriteButton.setImage(UIImage(named: isFav ? "favorite-added" : "favorite"), for: .normal)
        }
        
        mainImage.sd_setImage(with: URL(string: "\(item?.thumbnail?.path?.replace(target: "http", withString: "https") ?? "").\(item?.thumbnail?.thumbnailExtension ?? "")")) { image, err, cache, url in
            if image == nil {
                self.mainImage.image = nil
            } else {
                UIView.animate(withDuration: 0.5) {
                    self.mainImage.alpha = 1
                }
            }
        }
        titleLabel.text = item?.name
        descriptionLabel.text = item?.resultDescription
    }
    
    @objc func favoriteTap() {
        if let item = self.item {
            delegate?.favorite(item: item)
        }
        
    }

}

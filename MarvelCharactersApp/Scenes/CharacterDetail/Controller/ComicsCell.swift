//
//  ComicsCell.swift
//  MarvelCharactersApp
//
//  Created by Emrullah Hancer on 13.08.2021.
//

import UIKit

class ComicsCell: UITableViewCell {

    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: ComicsResult?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with item: ComicsResult?) {
       
        if self.item == nil {
            Loader.show(self.mainImage)
        }
        
        self.item = item
        
        self.mainImage.sd_setImage(with: URL(string: "\(item?.thumbnail?.path?.replace(target: "http", withString: "https") ?? "").\(item?.thumbnail?.thumbnailExtension ?? "")")) { image, err, cache, url in
            Loader.hide(self.mainImage)
            if err != nil {
                self.mainImage.image = nil
            }
        }
        
        titleLabel.text = item?.title
        descriptionLabel.text = item?.resultDescription
    }
    
}

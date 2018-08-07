//
//  ItemTableViewCell.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(item: ItemModel){
        if let title = item.title{
            lbTitle.text = title
        }
        if let url = item.image_url{
            imgImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "default"))
        }
        else{
            imgImage.image = UIImage(named: "default")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

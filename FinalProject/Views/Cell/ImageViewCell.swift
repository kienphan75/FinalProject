//
//  ImageViewCell.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import UIKit

class ImageViewCell: UICollectionViewCell {

    @IBOutlet weak var imgImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func set(url: String){
        imgImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "default"))
    }
}

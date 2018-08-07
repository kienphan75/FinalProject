//
//  PeopleViewCell.swift
//  FinalProject
//
//  Created by kien on 8/6/18.
//  Copyright © 2018 kien. All rights reserved.
//

import UIKit

class PeopleViewCell: UICollectionViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var imgImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func set(peo: PeopleModel){
        if let name = peo.name{
            lbName.text = name
        }
        if let url = peo.image_url{
            imgImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "default"))

        }
    }

}

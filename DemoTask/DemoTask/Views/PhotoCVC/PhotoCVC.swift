//
//  PhotoCVC.swift
//  DemoTask
//
//  Created by Ahmed Hafez on 12/3/22.
//

import UIKit
import SDWebImage

class PhotoCVC: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(url: String) {
        imgView.sd_setImage(with:URL(string: url), placeholderImage: UIImage(systemName: "gear"))
    }

}

//
//  ProductTableViewCell.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import UIKit
import SDWebImage

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: FLAnimatedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upvoteLabel: UILabel!
    
    func configure(_ post: PostPresention) {
        thumbnailImageView.sd_setImage(with: post.imageUrl)
        titleLabel.text = post.title
        descriptionLabel.text = post.description
        upvoteLabel.text = post.upvoting
    }
}

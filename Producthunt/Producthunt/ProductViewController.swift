//
//  ProductViewController.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import UIKit
import SDWebImage

class ProductViewController: UIViewController {
    var viewModel: ProductViewModelProtocol!
    
    @IBOutlet weak var postImageView: FLAnimatedImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var upvoteNumberLabel: UILabel!
    
    var post: Post!
    var presentationPost: DetailedPresentationPost!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = ProductModel(post: post, details: nil)
        viewModel = ProductViewModel(model: model)
        viewModel.controllerNotificator = self
        
        viewModel.loadPostDetails()
        
        presentationPost = DetailedPresentationPost(post: post)
        
        titleLabel.text = presentationPost.title
        descriptionLabel.text = presentationPost.description
        upvoteNumberLabel.text = presentationPost.upvoting
    }
    
    @IBAction func getItButtonDidTouch(_ sender: Any) {
        if let url = presentationPost.buttonUrl,
            UIApplication.shared.canOpenURL(url) {
            _ = UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension ProductViewController: ProductControllerNotificator {
    func updatePostDetail(with imageUrl: URL?, postUrl: URL?) {
        presentationPost.buttonUrl = postUrl
        presentationPost.imageUrl = imageUrl
        
        postImageView.sd_setImage(with: imageUrl)
    }
}

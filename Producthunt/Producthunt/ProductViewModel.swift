//
//  ProductViewModel.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

class ProductViewModel: ProductViewModelProtocol {
    var model: ProductModelProtocol!
    
    var data: DetailedPresentationPost!
    
    weak var controllerNotificator: ProductControllerNotificator?
    
    init(model: ProductModelProtocol) {
        self.model = model
    }
    
    func loadPostDetails() {
        DNServer.shared.loadPost(with: model.post.id) {
            response in
            
            let (_, detailedPost) = response
            
            if let detailedPost = detailedPost {
                self.model.details = detailedPost
                
                let postURL = URL(string: detailedPost.url)
                let imageUrl = URL(string: detailedPost.screenshotUrl)
                self.controllerNotificator?.updatePostDetail(with: imageUrl, postUrl: postURL)
            }
        }
    }
}

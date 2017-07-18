//
//  DetailedPost.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

struct DetailedPresentationPost {
    var title: String
    var description: String
    var upvoting: String
    
    var imageUrl: URL?
    var buttonUrl: URL?
    
    init(post: Post) {
        self.title = post.title
        self.description = post.descripion
        self.upvoting = "Upvoting: \(post.upvoteNumber)"
    }
}

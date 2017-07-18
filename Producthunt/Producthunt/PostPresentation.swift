//
//  PostPresentation.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

struct PostPresention {
    var imageUrl: URL
    var title: String
    var description: String = ""
    var upvoting: String
    
    init(imageUrl: String, title: String, description: String = "", upvoting: Int) {
        self.imageUrl = URL(string: imageUrl)!
        self.title = title
        self.description = description
        self.upvoting = "Upvoting \(upvoting)"
    }
}

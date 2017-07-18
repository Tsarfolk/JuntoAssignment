//
//  DetailedPost.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation
import ObjectMapper

struct DetailedPost: Mappable {
    var url: String = ""
    var screenshotUrl: String = ""
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        url <- map["post.redirect_url"]
        screenshotUrl <- map["post.screenshot_url.300px"]
    }
}

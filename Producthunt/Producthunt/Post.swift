//
//  Post.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

struct PostArray: Mappable {
    var posts = [Post]()
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        posts <- map["posts"]
    }
}

struct Post: Mappable {
    var id: Int = 0
    var title: String = ""
    var descripion: String = ""
    var upvoteNumber: Int = 0
    var thumbnail: String = ""
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        descripion = ""
        
        id <- map["id"]
        title <- map["name"]
        upvoteNumber <- map["votes_count"]
        thumbnail <- map["thumbnail.image_url"]
    }
}

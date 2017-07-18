//
//  Category.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class CategoryArray: Mappable {
    dynamic var categories = [Category]()
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.categories <- map["categories"]
    }
}

class Category: Object, Mappable {
    dynamic var id: Int = 0
    dynamic var name: String = ""
    
    required convenience init?(map: Map) { self.init() }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}

class CategoryManager {
    static let shared = CategoryManager()
    
    var isCategoriesLoaded: Bool {
        get {
            if fetchCategories().count > 0 {
                return true
            } else {
                return false
            }
        }
    }
    
    func fetchCategories() -> Results<Category> {
        let realm = try! Realm()
        
        return realm.objects(Category.self)
    }
    
    func save(_ categories: [Category]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(categories)
        }
    }
}

class CategoryLoader {
    static let shared = CategoryLoader()
    
    func loadCategories() {
        DNServer.shared.loadCategories {
            response in
            
            let (_, categories) = response
            
            if let categories = categories {
                CategoryManager.shared.save(categories)
            }
        }
    }
}

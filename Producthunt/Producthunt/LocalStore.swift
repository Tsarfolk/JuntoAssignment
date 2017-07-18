//
//  LocalStore.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

class LocalStore {
    static let shared = LocalStore()
    
    let def = UserDefaults.standard
    
    private enum EntityType: String {
        case activeCategory = "category"
    }
    
    func saveActiveCategory(index: Int) {
        def.set(index, forKey: EntityType.activeCategory.rawValue)
    }
    
    func activeCategory() -> Int {
        return def.integer(forKey: EntityType.activeCategory.rawValue)
    }
}

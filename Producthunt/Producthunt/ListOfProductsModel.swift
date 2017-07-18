//
//  ListOfProducts.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

struct ListOfProductsModel: ListOfProductsModelProtocol {
    weak var viewModelNotificator: ListOfProductsViewModelNotificator?
    
    var posts = [Post]() {
        didSet {
            viewModelNotificator?.updatePostSource()
        }
    }
    var activeCategory: Int {
        get {
            return LocalStore.shared.activeCategory()
        }
    }
}

//
//  ListOfProductsContracts.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

protocol ListOfProductsViewModelProtocol {
    weak var controllerNotificator: ListOfProductsControllerNotificator? { get set }
    var model: ListOfProductsModelProtocol! { get }
    
    var source: [PostPresention] { get set }
    var navigationBarTitle: String { get }
    
    func loadPosts(_ callBack: (() -> ())?)
}

protocol ListOfProductsModelProtocol {
    weak var viewModelNotificator: ListOfProductsViewModelNotificator? { get set }
    
    var posts: [Post] { get set }
    var activeCategory: Int { get }
}

protocol ListOfProductsControllerNotificator: class {
    func dataSourceDidUpdate()
}

protocol ListOfProductsViewModelNotificator: class {
    func updatePostSource()
}

protocol ListOfCategoryDismissalDelegate: class {
    func categoryWasPicked(_ title: String)
}

//
//  File.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

class ListOfCategoriesViewModel: ListOfCategoriesViewModelProtocol, ListOfCategoriesViewModelNotificator {
    var model: ListOfCategoriesModelProtocol!
    weak var controllerNotificator: ListOfCategoriesControllerNotificator?
    
    var source = [String]()
    
    init(model: ListOfCategoriesModelProtocol) {
        self.model = model
        self.model.viewModelNotificator = self
    }
    
    // MARK: ListOfCategoriesViewModelInput
    
    func updateCategory(with index: Int) {
        LocalStore.shared.saveActiveCategory(index: index)
        controllerNotificator?.dismissViewController()
    }
    
    func loadCategoriesIfNeeded() {
        if model.categories.count == 0 {
            CategoryLoader.shared.loadCategories()
        } else {
           updateSource()
        }
    }
    
    // MARK: ListOfCategoriesModelNotification
    
    func updateSource() {
        source = model.categories.map { $0.name }
        controllerNotificator?.updateSource()
    }
}

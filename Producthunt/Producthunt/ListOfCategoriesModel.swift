//
//  ListOfCategoriesModel.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation
import RealmSwift

class ListOfCategoriesModel: ListOfCategoriesModelProtocol {
    weak var viewModelNotificator: ListOfCategoriesViewModelNotificator?
    
    var categories: Results<Category> = CategoryManager.shared.fetchCategories()
    var activeCategory: Int?
    var notificationToken: NotificationToken? = nil
    
    
    init() {
        setObserver()
    }
    
    func setObserver() {
        notificationToken = categories.addNotificationBlock { (changes: RealmCollectionChange) in
            switch changes {
            case .error: break
            case .update, .initial: self.viewModelNotificator?.updateSource()
            }
        }
    }
    
}

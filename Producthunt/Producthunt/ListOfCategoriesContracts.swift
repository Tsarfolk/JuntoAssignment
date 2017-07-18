//
//  ListOfCategoriesContracts.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation
import RealmSwift

protocol ListOfCategoriesViewModelProtocol: class {
    var source: [String] { get }
    
    func updateCategory(with index: Int)
    func loadCategoriesIfNeeded()
    weak var controllerNotificator: ListOfCategoriesControllerNotificator? { get set }
}

protocol ListOfCategoriesModelProtocol {
    var activeCategory: Int? { get set }
    var categories: Results<Category> { get set }
    weak var viewModelNotificator: ListOfCategoriesViewModelNotificator? { get set }
}

protocol ListOfCategoriesViewModelNotificator: class {
    func updateSource()
}

protocol ListOfCategoriesControllerNotificator: class {
    func updateSource()
    func dismissViewController()
}

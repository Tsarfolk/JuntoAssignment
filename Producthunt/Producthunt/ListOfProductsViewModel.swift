//
//  ListOfProductsViewModel.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

class ListOfProductsViewModel: ListOfProductsViewModelProtocol, ListOfProductsViewModelNotificator {
    var model: ListOfProductsModelProtocol!
    
    weak var controllerNotificator: ListOfProductsControllerNotificator?
    
    var source = [PostPresention]()
    
    init(model: ListOfProductsModelProtocol) {
        self.model = model
        self.model.viewModelNotificator = self
    }
    
    // MARK: ListOfProductsViewModelProtocol
    
    var navigationBarTitle: String {
        get {
            let categories = CategoryManager.shared.fetchCategories()
            return categories[LocalStore.shared.activeCategory()].name
        }
    }
    
    func loadPosts(_ callBack: (() -> ())? = nil) {
        let categories = CategoryManager.shared.fetchCategories()
        let categoryName = categories.count > 0 ? categories[model.activeCategory].name.lowercased() : "tech"
        
        DNServer.shared.loadPosts(with: categoryName) {
            [weak self] response in
            
            let (_, posts) = response
            
            if let posts = posts {
                self?.model.posts = posts
            }
            
            callBack?()
        }
    }
    
    // MARK: ListOfProductsViewModelNotificator
    
    func updatePostSource() {
        source = []
        
        for post in model.posts {
            source.append(PostPresention(imageUrl: post.thumbnail, title: post.title, description: post.descripion, upvoting: post.upvoteNumber))
        }
        
        controllerNotificator?.dataSourceDidUpdate()
    }
}

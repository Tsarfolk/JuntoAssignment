//
//  ProductContracts.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation

protocol ProductViewModelProtocol {
    weak var controllerNotificator: ProductControllerNotificator? { get set }
    
    func loadPostDetails()
}

protocol ProductModelProtocol {
    var post: Post { get set }
    var details: DetailedPost? { get set }
}

protocol ProductControllerNotificator: class {
    func updatePostDetail(with imageUrl: URL?, postUrl: URL?)
}

//
//  DNServer.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum DNStatus {
    case success
    case noConnection
}

class DNServer {
    static var shared = DNServer()
    
    private let accessToken = "591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    
    private lazy var session: SessionManager = {
        let session = SessionManager.default
        session.adapter = AccessTokenAdapter(accessToken: self.accessToken)
        
        return session
    }()
    
    private enum Router {
        case listOfPosts(category: String)
        case listOfCategories
        case post(id: Int)
        case tokenTest
        
        var url: URL {
            let baseUrl = "https://api.producthunt.com/v1/"
            var subroute = ""
            
            switch self {
            case .listOfPosts(let category): subroute = "posts/all?search[category]=\(category)"
            case .listOfCategories: subroute = "categories"
            case .post(let id): subroute = "posts/\(id)"
            case .tokenTest: subroute = "me"
            }
            
            let urlString = baseUrl + subroute
            
            return URL(string: urlString)!
        }
    }
    
    func loadCategories(_ callBack: @escaping (DNStatus, [Category]?) -> ()) {
        let url = Router.listOfCategories.url
        
        session.request(url).responseJSON {
            resp in
            
            print(resp)
            
            if let data = resp.data, let jsonString = String(data: data, encoding: .utf8) {
                let categoriesArray = Mapper<CategoryArray>().map(JSONString: jsonString)
                callBack(.success, categoriesArray?.categories)
            } else {
                callBack(.noConnection, nil)
            }
        }
    }
    
    func loadPosts(with categoryName: String, callBack: @escaping (DNStatus, [Post]?) -> ()) {
        let url = Router.listOfPosts(category: categoryName).url
        
        session.request(url).responseJSON {
            resp in
            
            print(resp)
            
            if let data = resp.data, let jsonString = String(data: data, encoding: .utf8) {
                let posts = Mapper<PostArray>().map(JSONString: jsonString)
                callBack(.success, posts?.posts)
            } else {
                callBack(.noConnection, nil)
            }
        }
    }
    
    func loadPost(with id: Int, callBack: @escaping (DNStatus, DetailedPost?) -> ()) {
        let url = Router.post(id: id).url
        
        session.request(url).responseJSON {
            resp in
            
            print(resp)
            
            if let data = resp.data, let jsonString = String(data: data, encoding: .utf8) {
                let postDetailes = Mapper<DetailedPost>().map(JSONString: jsonString)
                callBack(.success, postDetailes)
            } else {
                callBack(.noConnection, nil)
            }
        }
    }
    
    // MARK: HELP
    
    func testToken() {
        let url = Router.tokenTest.url
        
        session.request(url).responseJSON {
            resp in
            
            print(resp)
        }
    }
}


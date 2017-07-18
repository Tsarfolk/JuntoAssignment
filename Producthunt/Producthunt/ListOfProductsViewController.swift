//
//  ListOfProductsViewController.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import UIKit

class ListOfProductsViewController: UIViewController {
    var viewModel: ListOfProductsViewModelProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate enum Router: String {
        case chooseCategory = "Choose Category"
        case showPostDetailes = "Show Post Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = ListOfProductsModel()
        viewModel = ListOfProductsViewModel(model: model)
        viewModel.controllerNotificator = self
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self, action: #selector(self.refresh(_:)), for: UIControlEvents.valueChanged)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(ProductTableViewCell.nib(), forCellReuseIdentifier: "cell")
        
        viewModel.loadPosts(nil)
        setNavigationBarTitle(viewModel.navigationBarTitle)
    }
    
    @IBAction func categoryButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: Router.chooseCategory.rawValue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Router.chooseCategory.rawValue {
            let navigation = segue.destination as! UINavigationController
            let destination = navigation.topViewController as! ListOfCategoriesViewController
            
            destination.dismissalDelegate = self
        }
        
        if segue.identifier == Router.showPostDetailes.rawValue {
            let destination = segue.destination as! ProductViewController
            
            destination.post = viewModel.model.posts[sender as! Int]
        }
    }
    
    func refresh(_ sender:AnyObject) {
        viewModel.loadPosts {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func setNavigationBarTitle(_ text: String) {
        self.navigationItem.title = text
    }
}

extension ListOfProductsViewController: ListOfCategoryDismissalDelegate {
    func categoryWasPicked(_ title: String = "tech") {
        setNavigationBarTitle(title)
        viewModel.loadPosts(nil)
    }
}

extension ListOfProductsViewController: ListOfProductsControllerNotificator {
    func dataSourceDidUpdate() {
        tableView.reloadData()
    }
}

extension ListOfProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Router.showPostDetailes.rawValue, sender: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ListOfProductsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        let post = viewModel.source[indexPath.row]
        cell.configure(post)
        
        return cell
    }
}

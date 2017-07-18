//
//  ListOfCategoriesViewController.swift
//  Producthunt
//
//  Created by Господин Бог on 18.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

//
//  ListOfCategoriesViewController.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import UIKit

class ListOfCategoriesViewController: UIViewController {
    var viewModel: ListOfCategoriesViewModelProtocol!
    var activeCategory: Int = LocalStore.shared.activeCategory()
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var dismissalDelegate: ListOfCategoryDismissalDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = ListOfCategoriesModel()
        viewModel = ListOfCategoriesViewModel(model: model)
        viewModel.controllerNotificator = self
        
        viewModel.loadCategoriesIfNeeded()
    }
    
    @IBAction func closeButtonDidTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ListOfCategoriesViewController: ListOfCategoriesControllerNotificator {
    func updateSource() {
        tableView.reloadData()
    }
    
    func dismissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ListOfCategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        viewModel.updateCategory(with: index)
        dismissalDelegate?.categoryWasPicked(viewModel.source[index])
    }
}

extension ListOfCategoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.source.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryTableViewCell
        let title = viewModel.source[indexPath.row]
        let isActive = indexPath.row == activeCategory
        
        cell.configure(title, isActive: isActive)
        
        return cell
    }
}

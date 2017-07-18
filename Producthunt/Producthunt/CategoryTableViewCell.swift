//
//  CategoryTableViewCell.swift
//  Producthunt
//
//  Created by Господин Бог on 17.07.17.
//  Copyright © 2017 Господин Бог. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String, isActive: Bool) {
        self.titleLabel.text = title
        self.titleLabel.textColor = isActive ? .gray : .black
    }
}

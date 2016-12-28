//
//  CartViewController.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-26.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import UIKit
import Eureka

class CartViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My order"
        
        setupForm()
        
    }
    
    private func setupForm() {
        
        guard let tableView = tableView else {
            return
        }
        
        UIHelper.setTableViewColor(tableView: tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        
        
    }

}

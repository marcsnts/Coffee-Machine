//
//  DrinksViewController.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-21.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import UIKit
import SnapKit
import Eureka

class DrinksViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Marc's Coffee Machine"
        setupForm()
        
    }
    
    private func setupForm() {
        let table = UITableView(frame: view.frame, style: UITableViewStyle.grouped)
        tableView = table
        
        view.addSubview(table)
        table.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(40, 0, 0, 0))
            make.size.equalTo(view)
        }
        super.viewDidLoad()
        form = Section("Hot Drinks")
            <<< BeverageRow() { row in
                row.value = HotDrink.Coffee
            }
            <<< BeverageRow() { row in
                row.value = HotDrink.Cappuccino
            }
            <<< BeverageRow() { row in
                row.value = HotDrink.HotChocolate
            }
            +++ Section()
    }

}

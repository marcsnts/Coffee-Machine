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
        
    let modifiersSegue = "Modifiers"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavigation()
        setupForm()
        
    }
    
    private func setupNavigation() {
        
        self.title = "Marc's Coffee Machine"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    private func setupForm() {
        
        tableView?.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        form = Section("Hot Drinks")
            <<< BeverageRow() { row in
                row.value = HotDrink.Coffee
                }.onCellSelection { cell, row in
                    Temporary.sharedInstance.selectedDrink = row.value
                    self.performSegue(withIdentifier: self.modifiersSegue, sender: self)
            }
            <<< BeverageRow() { row in
                row.value = HotDrink.Cappuccino
                }.onCellSelection { cell, row in
                    Temporary.sharedInstance.selectedDrink = row.value
                    self.performSegue(withIdentifier: self.modifiersSegue, sender: self)
            }
            <<< BeverageRow() { row in
                row.value = HotDrink.HotChocolate
                }.onCellSelection { cell, row in
                    Temporary.sharedInstance.selectedDrink = row.value
                    self.performSegue(withIdentifier: self.modifiersSegue, sender: self)
            }
            +++ Section()
        
    }

}

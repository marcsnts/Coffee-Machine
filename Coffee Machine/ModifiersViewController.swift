//
//  ModifiersViewController.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-21.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import UIKit
import SnapKit
import Eureka

class ModifiersViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    private func setupForm() {
        
        tableView?.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        form = Section()
            <<< SelectRow() {
                $0.title = "swegg"
                $0.value = false
                }.onCellSelection { cell, row in
                    cell.update()
            }
        +++ Section()
    }

}

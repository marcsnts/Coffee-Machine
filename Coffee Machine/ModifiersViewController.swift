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
        
        guard let selectedDrink = Temporary.sharedInstance.selectedDrink else {
            return
        }
        
        tableView?.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        form = Section("Size")
            <<< SelectRow() {
                $0.title = "Small"
                $0.value = true
            }.onCellSelection { cell, row in
                cell.update()
            }
            <<< SelectRow() {
                let priceDifference = getSizePriceDifference(type: selectedDrink, size1: .Small, size2: .Medium)
                $0.title = "Medium +$\(String(format: "%.2f", priceDifference))"
                $0.value = false
                }.onCellSelection { cell, row in
                    cell.update()
            }
            <<< SelectRow() {
                let priceDifference = getSizePriceDifference(type: selectedDrink, size1: .Small, size2: .Large)
                $0.title = "Large +$\(String(format: "%.2f", priceDifference))"
                $0.value = false
                }.onCellSelection { cell, row in
                    cell.update()
            }
            
        +++ Section()

    }
    
    private func getSizePriceDifference(type: HotDrink, size1: BeverageSize, size2: BeverageSize) -> Double {
        
        guard size1 != size2 else {
            return 0
        }
        
        var size1Price = 0.00
        var size2Price = 0.00
        
        switch type {
        case .Cappuccino:
            switch size1 {
            case .Large:
                size1Price = Constants.CAPPUCCINO_LARGE_PRICE
            case .Medium:
                size1Price = Constants.CAPPUCCINO_MEDIUM_PRICE
            case .Small:
                size1Price = Constants.CAPPUCCINO_SMALL_PRICE
            }
            switch size2 {
            case .Large:
                size2Price = Constants.CAPPUCCINO_LARGE_PRICE
            case .Medium:
                size2Price = Constants.CAPPUCCINO_MEDIUM_PRICE
            case .Small:
                size2Price = Constants.CAPPUCCINO_SMALL_PRICE
            }
        case .Coffee:
            switch size1 {
            case .Large:
                size1Price = Constants.COFFEE_LARGE_PRICE
            case .Medium:
                size1Price = Constants.COFFEE_MEDIUM_PRICE
            case .Small:
                size1Price = Constants.COFFEE_SMALL_PRICE
            }
            switch size2 {
            case .Large:
                size2Price = Constants.COFFEE_LARGE_PRICE
            case .Medium:
                size2Price = Constants.COFFEE_MEDIUM_PRICE
            case .Small:
                size2Price = Constants.COFFEE_SMALL_PRICE
            }
        case .HotChocolate:
            switch size1 {
            case .Large:
                size1Price = Constants.HOTCHOCOLATE_LARGE_PRICE
            case .Medium:
                size1Price = Constants.HOTCHOCOLATE_MEDIUM_PRICE
            case .Small:
                size1Price = Constants.HOTCHOCOLATE_SMALL_PRICE
            }
            switch size2 {
            case .Large:
                size2Price = Constants.HOTCHOCOLATE_LARGE_PRICE
            case .Medium:
                size2Price = Constants.HOTCHOCOLATE_MEDIUM_PRICE
            case .Small:
                size2Price = Constants.HOTCHOCOLATE_SMALL_PRICE
            }
        }
        
        return size2Price - size1Price
        
    }

}




















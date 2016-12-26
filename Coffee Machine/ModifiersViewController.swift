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
    
    var valuesDictionary = [String:Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let drink = Temporary.sharedInstance.selectedDrink {
            self.title = drink.rawValue
        }
        setupForm()
        setupAddToBagButton()
    }
    
    private func setupAddToBagButton() {
        let addToBagButton = UIButton()
        
        addToBagButton.backgroundColor = Colors.ORANGE
        addToBagButton.setTitle("ADD TO BAG", for: UIControlState.normal)
        addToBagButton.addTarget(self, action: #selector(ModifiersViewController.addToBagTapped(sender:)), for: UIControlEvents.touchUpInside)
        view.addSubview(addToBagButton)
        
        addToBagButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    
    }
    
    func addToBagTapped(sender: UIButton!) {
        
        UIView.animate(withDuration: 0.6, animations: {
            sender.alpha = 0.5
            sender.titleLabel?.alpha = 0.5
        })
        
        UIView.animate(withDuration: 0.6, animations: {
            sender.alpha = 1
            sender.titleLabel?.alpha = 1
        })
        
        addOrderToBag()
        
    }
    
    private func addOrderToBag() {
        
        guard let selectedDrink = Temporary.sharedInstance.selectedDrink else {
            return
        }
        
        var size: BeverageSize
        if valuesDictionary["Small"] as? Bool == true {
            size = .Small
        }
        else if valuesDictionary["Mediume"] as? Bool == true {
            size = .Medium
        }
        else {
            size = .Large
        }
        
        
        switch selectedDrink {
        case .Cappuccino:
            Temporary.sharedInstance.order.append(Cappuccino(size: size))
        case .Coffee:
            if let sugar = valuesDictionary["Sugar"] as? Double {
                Temporary.sharedInstance.order.append(Coffee(size: size, sugar: Int(sugar)))
            }
        case .HotChocolate:
            if let whippedCream = valuesDictionary["WhippedCream"] as? Bool {
                Temporary.sharedInstance.order.append(HotChocolate(size: size, whippedCream: whippedCream))
            }
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    private func setupForm() {
        
        guard let selectedDrink = Temporary.sharedInstance.selectedDrink, let tableView = tableView else {
            return
        }
        
        UIHelper.setTableViewColor(tableView: tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }

        SelectRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = Colors.CREAM
        }
        
        StepperRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = Colors.CREAM
        }
        
        form = Section("Sizes")
            <<< SelectRow("Small") {
                $0.title = "Small"
                $0.value = true
            }.onCellSelection { cell, row in
                self.updateSizeRow(cell: cell, row: row)
            }
            
            <<< SelectRow("Medium") {
                let priceDifference = getSizePriceDifference(type: selectedDrink, size1: .Small, size2: .Medium)
                $0.title = "Medium +$\(String(format: "%.2f", priceDifference))"
                $0.value = false
            }.onCellSelection { cell, row in
                self.updateSizeRow(cell: cell, row: row)
            }
            
            <<< SelectRow("Large") {
                let priceDifference = getSizePriceDifference(type: selectedDrink, size1: .Small, size2: .Large)
                $0.title = "Large +$\(String(format: "%.2f", priceDifference))"
                $0.value = false
            }.onCellSelection { cell, row in
                self.updateSizeRow(cell: cell, row: row)
            }
            
            +++ Section("Add-ons") {
                //Hide this section if cappuccino
                $0.hidden = Condition.function(["Medium"], { form in
                    return selectedDrink == .Cappuccino ? true : false
                })
            }
            <<< StepperRow("Sugar") {
                $0.title = "Sugar"
                $0.value = 0
                //Hide if not coffee
                $0.hidden = Condition.function(["Medium"], { form in
                    return selectedDrink == .Coffee ? false : true
                })
            }.cellSetup { cell, row in
                cell.textLabel?.font = UIHelper.CELL_FONT
                cell.stepper.tintColor = Colors.ORANGE
                cell.valueLabel.textColor = Colors.ORANGE
                cell.stepper.maximumValue = 5
                cell.stepper.minimumValue = 0
                cell.stepper.stepValue = 1
            }.onChange { row in
                self.valuesDictionary = self.form.values()
            }
            <<< SelectRow("WhippedCream") {
                $0.title = "Whipped cream"
                $0.value = false
                //Hide if not hot chocolate
                $0.hidden = Condition.function(["Medium"], { form in
                    return selectedDrink == .HotChocolate ? false : true
                })
            }.onCellSelection { cell, row in
                self.updateSelectRow(cell: cell, row: row)
            }
         
        
        self.valuesDictionary = form.values()
    }
    
    
    private func updateSelectRow(cell: SelectCell, row: SelectRow) {
        row.value = row.value == true ? false : true
        cell.update()
    }
    
    private func updateSizeRow(cell: SelectCell, row: SelectRow) {
        self.deselectSizes()
        updateSelectRow(cell: cell, row: row)
        self.valuesDictionary = self.form.values()
    }
    
    //Function used to turn all sizes to false in order to give the experience of being able to only have one size selected
    private func deselectSizes() {

        guard let smallRow: SelectRow = form.rowBy(tag: "Small"), let mediumRow: SelectRow = form.rowBy(tag: "Medium"), let largeRow: SelectRow = form.rowBy(tag: "Large") else {
            return
        }
        
        smallRow.value = false
        mediumRow.value = false
        largeRow.value = false
        smallRow.updateCell()
        mediumRow.updateCell()
        largeRow.updateCell()
        
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




















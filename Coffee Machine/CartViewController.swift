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
        setupCheckoutButton()
        
    }
    
    private func setupCheckoutButton() {
        let checkoutButton = UIButton()
        
        checkoutButton.backgroundColor = Colors.ORANGE
        checkoutButton.setTitle("CHECKOUT", for: UIControlState.normal)
        checkoutButton.addTarget(self, action: #selector(CartViewController.checkoutTapped(sender:)), for: UIControlEvents.touchUpInside)
        view.addSubview(checkoutButton)
        
        checkoutButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
    }
    
    func checkoutTapped(sender: UIButton!) {
        
        UIView.animate(withDuration: 0.6, animations: {
            sender.alpha = 0.4
            sender.titleLabel?.alpha = 0.2
        })
        
        UIView.animate(withDuration: 0.6, animations: {
            sender.alpha = 1
            sender.titleLabel?.alpha = 1
        })


        UIHelper.loadingAnimation(text: "Processing your order")
        
        var orderDictionary = [[String: Any]]()
        
        for beverage in Temporary.sharedInstance.order {
            switch type(of: beverage) {
            case is HotChocolate.Type:
                if let beverage = beverage as? HotChocolate {
                    orderDictionary.append([
                        "drink": "hotchocolate",
                        "size": beverage.size.rawValue,
                        "whippedcream": beverage.whippedCream
                    ])
                }
            case is Coffee.Type:
                if let beverage = beverage as? Coffee {
                    orderDictionary.append([
                        "drink": "coffee",
                        "size": beverage.size.rawValue,
                        "sugar": beverage.sugar
                    ])
                }
            case is Cappuccino.Type:
                orderDictionary.append([
                    "drink": "cappuccino",
                    "size": beverage.size.rawValue
                ])
            default: break
            }
        }
        
        NetworkRequest.postOrder(order: orderDictionary)
    }
    
    private func setupForm() {
        
        guard let tableView = tableView else {
            return
        }
        
        UIHelper.setTableViewColor(tableView: tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 0, 60, 0))
        }
        
        form +++ makeTotalSection()
        form +++ makeOrderSection()
        
    }
    
    private func makeTotalSection() -> Section {
        
        let totalSection = Section("Total")
        var subtotal = 0.00
        
        for beverage in Temporary.sharedInstance.order {
            if let price = beverage.price {
                subtotal = subtotal + price
            }
        }
        
        let tax = subtotal * Constants.TAX
        let total = subtotal + tax
        
        DecimalRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = Colors.CREAM
        }
        
        totalSection <<< DecimalRow("subtotal") {
            $0.useFormatterDuringInput = true
            $0.title = "Subtotal"
            $0.value = subtotal
            let formatter = CurrencyFormatter()
            formatter.locale = .current
            formatter.numberStyle = .currency
            $0.formatter = formatter
            $0.disabled = true
        }
        
        totalSection <<< DecimalRow("tax") {
            $0.useFormatterDuringInput = true
            $0.title = "Tax"
            $0.value = tax
            let formatter = CurrencyFormatter()
            formatter.locale = .current
            formatter.numberStyle = .currency
            $0.formatter = formatter
            $0.disabled = true
        }
        
        totalSection <<< DecimalRow("total") {
            $0.useFormatterDuringInput = true
            $0.title = "Total"
            $0.value = total
            let formatter = CurrencyFormatter()
            formatter.locale = .current
            formatter.numberStyle = .currency
            $0.formatter = formatter
            $0.disabled = true
        }
        
        return totalSection
        
    }
    
    private func makeOrderSection() -> Section {
        
        let orderSection = Section("My Order")
        
        for beverage in Temporary.sharedInstance.order {
            orderSection <<< BeverageRow() {
                $0.value = beverage
            }
        }
        
        return orderSection
        
    }

}

//Eureka framework extension taken from eureka's example
class CurrencyFormatter : NumberFormatter, FormatterProtocol {
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, range rangep: UnsafeMutablePointer<NSRange>?) throws {
        guard obj != nil else { return }
        let str = string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator: "")
        obj?.pointee = NSNumber(value: (Double(str) ?? 0.0)/Double(pow(10.0, Double(minimumFractionDigits))))
    }
    
    func getNewPosition(forPosition position: UITextPosition, inTextInput textInput: UITextInput, oldValue: String?, newValue: String?) -> UITextPosition {
        return textInput.position(from: position, offset:((newValue?.characters.count ?? 0) - (oldValue?.characters.count ?? 0))) ?? position
    }
}

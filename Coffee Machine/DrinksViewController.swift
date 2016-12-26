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
    let orderButton = UIButton()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavigation()
        setupForm()
        setupOrderButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderButton.isHidden = Temporary.sharedInstance.order.count > 0 ? false : true
        orderButton.setTitle("ORDER (\(Temporary.sharedInstance.order.count))", for: UIControlState.normal)
    }
    
    private func setupOrderButton() {
        
        orderButton.isHidden = true
        orderButton.backgroundColor = Colors.ORANGE
        orderButton.setTitle("ORDER", for: UIControlState.normal)
        view.addSubview(orderButton)
        orderButton.addTarget(self, action: #selector(DrinksViewController.orderTapped(sender:)), for: UIControlEvents.touchUpInside)

        
        orderButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalToSuperview()
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
    
    }
    
    func orderTapped(sender: UIButton!) {
        UIView.animate(withDuration: 0.6, animations: {
            sender.alpha = 0.5
            sender.titleLabel?.alpha = 0.5
        })
        
        UIView.animate(withDuration: 0.6, animations: {
            sender.alpha = 1
            sender.titleLabel?.alpha = 1
        })
    }
    
    private func setupNavigation() {
        
        self.title = "Marc's Coffee Machine"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    private func setupForm() {
        
        guard let tableView = tableView else {
            return
        }
        
        UIHelper.setTableViewColor(tableView: tableView)
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        BeverageRow.defaultCellSetup = { cell, row in
            cell.backgroundColor = Colors.CREAM
        }
        
        form = Section("Hot Drinks")
            <<< BeverageRow() { row in
                row.value = HotDrink.Coffee
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
            
            <<< BeverageRow() { row in
                row.value = HotDrink.Cappuccino
                }.onCellSelection { cell, row in
                    Temporary.sharedInstance.selectedDrink = row.value
                    self.performSegue(withIdentifier: self.modifiersSegue, sender: self)
            }
            +++ Section()
        
    }

}

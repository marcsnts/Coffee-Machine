//
//  BeverageCell.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-21.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation
import Eureka
import UIKit
import SnapKit

public enum HotDrink {
    case Coffee, HotChocolate, Cappuccino
}

public class BeverageCell : Cell<HotDrink>, CellType{
    
    let beverageImageView = UIImageView(image: nil)
    let beverageLabel = UILabel()
    
    public override func setup() {
        height = {120}
        super.setup()
    }
    
    public override func update() {
        
    }
    
    private func setupImage() {
        
        guard let beverage = row.value else {
            return
        }
        
        switch beverage {
        case .Cappuccino:
            beverageImageView.image = UIImage(named: "cappuccino")
            beverageLabel.text = "Cappuccino"
        case .Coffee:
            beverageImageView.image = UIImage(named: "coffee")
            beverageLabel.text = "Coffee"
        case .HotChocolate:
            beverageImageView.image = UIImage(named: "hot-drink")
            beverageLabel.text = "Hot Chocolate"
        }
        
        
        
        self.addSubview(beverageImageView)
        
        beverageImageView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 120, height: 80))
            make.centerY.equalTo(self.center)
            make.left.equalTo(self).offset(10)
        }
        
        
    }
    
}

public final class BeverageRow: Row<BeverageCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<BeverageCell>(nibName: "BeverageCell")
    }
    
}




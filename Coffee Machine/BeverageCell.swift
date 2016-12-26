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

public class BeverageCell : Cell<HotDrink>, CellType{
    
    let beverageImageView = UIImageView(image: nil)
    let beverageLabel = UILabel()
    let beveragePriceLabel = UILabel()
    
    public override func setup() {
        height = {120}
        setupCell()
        super.setup()
    }
    
    public override func update() {
        
    }
    
    private func setupCell() {
        
        guard let beverage = row.value else {
            return
        }
        
        let beverageImageSize = CGSize(width: 120, height: 80)
        let beverageImageLeftPadding = 15
        let beverageLabelLeftPadding = 10
        let beveragePriceLabelTopPadding = 5
        
        beverageImageView.contentMode = UIViewContentMode.scaleAspectFit
        beverageLabel.textAlignment = NSTextAlignment.center
        beveragePriceLabel.textAlignment = NSTextAlignment.center
        beveragePriceLabel.font = UIHelper.CELL_FONT
        beveragePriceLabel.textColor = UIColor.darkGray
        
        switch beverage {
        case .Cappuccino:
            beverageImageView.image = UIImage(named: "cappuccino")
            beverageLabel.text = "Cappuccino"
            beveragePriceLabel.text = "$\(Constants.CAPPUCCINO_SMALL_PRICE)"
        case .Coffee:
            beverageImageView.image = UIImage(named: "coffee")
            beverageLabel.text = "Coffee"
            beveragePriceLabel.text = "$\(Constants.COFFEE_SMALL_PRICE)"
        case .HotChocolate:
            beverageImageView.image = UIImage(named: "hot-drink")
            beverageLabel.text = "Hot Chocolate"
            beveragePriceLabel.text = "$\(Constants.HOTCHOCOLATE_SMALL_PRICE)"
        }
        
        self.addSubview(beverageImageView)
        self.addSubview(beverageLabel)
        self.addSubview(beveragePriceLabel)
        
        beverageImageView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(beverageImageSize)
            make.centerY.equalTo(self.center)
            make.left.equalTo(self).offset(beverageImageLeftPadding)
        }
        
        beverageLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.center)
            make.left.equalTo(beverageImageView.snp.right).offset(beverageLabelLeftPadding)
        }
        
        beveragePriceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(beverageLabel.snp.bottom).offset(beveragePriceLabelTopPadding)
            make.left.equalTo(beverageLabel)
        }
        
    }
    
}

public final class BeverageRow: Row<BeverageCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<BeverageCell>(nibName: "BeverageCell")
    }
    
}




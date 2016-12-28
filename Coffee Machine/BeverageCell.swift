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

public class BeverageCell : Cell<Beverage>, CellType{
    
    let beverageImageView = UIImageView(image: nil)
    let beverageLabel = UILabel()
    let beveragePriceLabel = UILabel()
    let beverageSizeLabel = UILabel()
    let beverageNoteLabel = UILabel()
    
    public override func setup() {
        height = {120}
        setupCell()
        super.setup()
    }
    
    public override func update() {
        
    }
    
    private func setupCellLabels() {
        
        guard let beverage = row.value else {
            return
        }
        
        let descriptionColor = UIColor.darkGray
        
        beverageLabel.textAlignment = NSTextAlignment.center
        beveragePriceLabel.textAlignment = NSTextAlignment.center
        beveragePriceLabel.font = UIHelper.CELL_FONT
        beveragePriceLabel.textColor = descriptionColor
        beverageSizeLabel.textAlignment = NSTextAlignment.center
        beverageSizeLabel.font = UIHelper.CELL_FONT
        beverageSizeLabel.textColor = descriptionColor
        beverageNoteLabel.textAlignment = NSTextAlignment.center
        beverageNoteLabel.font = UIHelper.CELL_FONT
        beverageNoteLabel.textColor = descriptionColor
        beverageNoteLabel.text = nil
        
        switch beverage {
        case is Cappuccino:
            guard let beverage = beverage as? Cappuccino else {
                return
            }
            beverageImageView.image = UIImage(named: "cappuccino")
            beverageLabel.text = "Cappuccino"
            beverageSizeLabel.text = beverage.size.rawValue
            if let price = beverage.price {
                beveragePriceLabel.text = "$\(String(format: "%.2f", price))"
            }
        case is Coffee:
            guard let beverage = beverage as? Coffee else {
                return
            }
            beverageImageView.image = UIImage(named: "coffee")
            beverageLabel.text = "Coffee"
            beverageSizeLabel.text = beverage.size.rawValue
            if let price = beverage.price {
                beveragePriceLabel.text = "$\(String(format: "%.2f", price))"
            }
            if beverage.sugar > 0 {
                beverageNoteLabel.text = "\(beverage.sugar) sugar"
            }
        case is HotChocolate:
            guard let beverage = beverage as? HotChocolate else {
                return
            }
            beverageImageView.image = UIImage(named: "hot-drink")
            beverageLabel.text = "Hot Chocolate"
            beverageSizeLabel.text = beverage.size.rawValue
            if let price = beverage.price {
                beveragePriceLabel.text = "$\(String(format: "%.2f", price))"
            }
            if beverage.whippedCream == true {
                beverageNoteLabel.text = "Add whipped cream"
            }
        default:
            print("No beverage type specified")
            break
        }
        
        self.addSubview(beverageImageView)
        self.addSubview(beverageLabel)
        self.addSubview(beveragePriceLabel)
        self.addSubview(beverageSizeLabel)
        self.addSubview(beverageNoteLabel)
        
    }
    
    private func setupCell() {
        
        guard row.value != nil else {
            return
        }

        let beverageImageSize = CGSize(width: 120, height: 80)
        beverageImageView.contentMode = UIViewContentMode.scaleAspectFit

        let beverageImageLeftPadding = 15
        let beverageLabelLeftPadding = 10
        let beverageLabelVerticalPadding = 5
        
        setupCellLabels()
        
        beverageImageView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(beverageImageSize)
            make.centerY.equalTo(self.center)
            make.left.equalTo(self).offset(beverageImageLeftPadding)
        }
        
        beverageSizeLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.center)
            make.left.equalTo(beverageImageView.snp.right).offset(beverageLabelLeftPadding)
        }
        
        beverageLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(beverageSizeLabel.snp.top).offset(beverageLabelVerticalPadding * -1)
            make.left.equalTo(beverageSizeLabel)
        }
        
        beveragePriceLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(beverageLabel.snp.bottom).offset(beverageLabelVerticalPadding)
            make.left.equalTo(beverageSizeLabel.snp.right).offset(beverageLabelLeftPadding)
        }

        beverageNoteLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(beverageSizeLabel.snp.bottom).offset(beverageLabelVerticalPadding)
            make.left.equalTo(beverageSizeLabel)
        }
        
    }
    
}

public final class BeverageRow: Row<BeverageCell>, RowType {
    
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<BeverageCell>(nibName: "BeverageCell")
    }
    
}




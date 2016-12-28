//
//  Beverages.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-21.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation

enum BeverageSize: String {
    case Small = "Small",
    Medium = "Medium",
    Large = "Large"
}

public enum HotDrink: String {
    case Coffee = "Coffee",
    HotChocolate = "Hot Chocolate",
    Cappuccino = "Cappuccino"
}

class Beverage: NSObject {
    
    var size: BeverageSize
    var price: Double?
    
    init(size: BeverageSize) {
        self.size = size
        self.price = nil
    }
        
}

class Coffee: Beverage {
    
    var sugar: Int
    
    init(size: BeverageSize, sugar: Int) {
        self.sugar = sugar
        super.init(size: size)
        
        switch self.size {
        case .Large:
            self.price = Constants.COFFEE_LARGE_PRICE
        case .Medium:
            self.price = Constants.COFFEE_MEDIUM_PRICE
        case .Small:
            self.price = Constants.COFFEE_SMALL_PRICE
        }
    }
    
    func addSugar() {
        self.sugar = self.sugar+1
    }
    
    func removeSugar() {
        guard self.sugar > 0 else {
            print("No sugar to remove")
            return
        }
        self.sugar = self.sugar-1
    }
}

class HotChocolate: Beverage {
    
    var whippedCream: Bool
    
    init(size: BeverageSize, whippedCream: Bool) {
        self.whippedCream = whippedCream
        super.init(size: size)
        
        switch self.size {
        case .Large:
            self.price = Constants.HOTCHOCOLATE_LARGE_PRICE
        case .Medium:
            self.price = Constants.HOTCHOCOLATE_MEDIUM_PRICE
        case .Small:
            self.price = Constants.HOTCHOCOLATE_SMALL_PRICE
        }
    }
    
    func addCream() {
        self.whippedCream = true
    }
    
    func removeCream() {
        self.whippedCream = false
    }
    
}

class Cappuccino: Beverage {
    
    override init(size: BeverageSize) {
        super.init(size: size)
        
        switch self.size {
        case .Large:
            self.price = Constants.CAPPUCCINO_LARGE_PRICE
        case .Medium:
            self.price = Constants.CAPPUCCINO_MEDIUM_PRICE
        case .Small:
            self.price = Constants.CAPPUCCINO_SMALL_PRICE
        }
    }
    
}









//
//  Beverages.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-21.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation

enum BeverageSize {
    case Small, Medium, Large
}

public enum HotDrink:String {
    case Coffee = "Coffee",
    HotChocolate = "Hot Chocolate",
    Cappuccino = "Cappuccino"
}

class Beverage: NSObject {
    
    var size: BeverageSize
    
    init(size: BeverageSize) {
        self.size = size
    }
    
    
}

class Coffee: Beverage {
    
    var sugar: Int
    
    init(size: BeverageSize, sugar: Int) {
        self.sugar = sugar
        super.init(size: size)
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
    }
    
    func addCream() {
        self.whippedCream = true
    }
    
    func removeCream() {
        self.whippedCream = false
    }
    
}

class Cappuccino: Beverage {
    
}









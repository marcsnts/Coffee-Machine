//
//  Temporary.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-25.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation

class Temporary: NSObject {
    
    static let sharedInstance = Temporary()
    
    var selectedDrink: HotDrink?
    
}

//
//  UIHelper.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-21.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation
import UIKit

class UIHelper {
    
    class func createLabel(text: String, font: UIFont, color: UIColor) -> UILabel {
    
        let label = UILabel()
        label.font = font
        label.text = text
        label.textColor = color
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 10
        
        return label
            
    }
    
}

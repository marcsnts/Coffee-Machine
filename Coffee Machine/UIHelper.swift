//
//  UIHelper.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-26.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

class UIHelper {
    
    static let CELL_FONT = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        
    class func setTableViewColor(tableView: UITableView) {
        tableView.backgroundColor = Colors.IVORY
    }
    
    
    class func loadingAnimation(text: String?) {
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultMaskType(.black)
        if let text = text {
            SVProgressHUD.show(withStatus: text)
        }
        else {
            SVProgressHUD.show()
        }
        SVProgressHUD.dismiss(withDelay: 2)
    }
    
    class func successfulAnimation(text: String) {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.showSuccess(withStatus: text)
        SVProgressHUD.dismiss(withDelay: 0.75)
    }
    
}

//
//  UIHelper.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-26.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class UIHelper {
    
    static let CELL_FONT = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
    
    class func setTableViewColor(tableView: UITableView) {
        tableView.backgroundColor = Colors.IVORY
    }
    
    class func successfulAnimation(view: UIView, text: String) {
                
        let hud = MBProgressHUD(view: view)
        view.addSubview(hud)
        hud.customView = UIImageView(image: UIImage(named: "Checkmark"))
        hud.mode = .customView
        hud.label.text = text
        hud.show(animated: true)
        hud.hide(animated: true, afterDelay: 1)

    }
    
}

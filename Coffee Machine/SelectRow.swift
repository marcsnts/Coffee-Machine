//
//  SelectRow.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-26.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import Foundation
import Eureka
import UIKit
import SnapKit

public class SelectCell : Cell<Bool>, CellType {
  
    let title = UILabel()
    
    public override func setup() {
    
        super.setup()
        selectionStyle = .none
        setupCell()
        
    }
    
    public override func update() {
        
        let nonSelectedColor = Colors.CREAM
        let selectedColor = Colors.ORANGE

        backgroundColor = row.value == true ? selectedColor : nonSelectedColor
        
    }
    
    private func setupCell() {
        
        title.text = row.title
        title.font = UIHelper.CELL_FONT
        self.addSubview(title)
        
        title.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }

    }

}

public final class SelectRow: Row<SelectCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<SelectCell>(nibName: "SelectCell")
    }
}

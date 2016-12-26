//
//  DrinksViewController.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2016-12-21.
//  Copyright © 2016 Marc Santos. All rights reserved.
//

import UIKit
import SnapKit

class DrinksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }


    private func setupView() {
        
        let coffeeImageView = UIImageView(image: UIImage(named: "coffee"))
        coffeeImageView.contentMode = UIViewContentMode.scaleAspectFit

//        let coffeeLabel = UIHelper.createLabel(text: "Coffee", font: Constants.DRINK_LABEL_FONT, color: Constants.DRINK_LABEL_FONT_COLOR)
        
        let cappuccinoImageView = UIImageView(image: UIImage(named: "cappuccino"))
        cappuccinoImageView.contentMode = UIViewContentMode.scaleAspectFit

//        let cappuccinoLabel = UIHelper.createLabel(text: "Cappuccino", font: Constants.DRINK_LABEL_FONT, color: Constants.DRINK_LABEL_FONT_COLOR)
        
        let hotchocolateImageView = UIImageView(image: UIImage(named: "hot-drink"))
        hotchocolateImageView.contentMode = UIViewContentMode.scaleAspectFit

//        let hotchocolateLabel = UIHelper.createLabel(text: "Hot Chocolate", font: Constants.DRINK_LABEL_FONT, color: Constants.DRINK_LABEL_FONT_COLOR)
        
        view.addSubview(coffeeImageView)
        view.addSubview(cappuccinoImageView)
        view.addSubview(hotchocolateImageView)
        
        coffeeImageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(view.center)
            make.top.equalTo(view).offset(40)
            make.size.equalTo(Constants.DRINK_IMAGE_SIZE)
        }
        
//        coffeeLabel.snp.makeConstraints { (make) -> Void in
//            make.centerX.equalTo(coffeeImageView.center)
//            make.top.equalTo(coffeeImageView.snp.bottom).offset(Constants.DRINK_LABEL_PADDING)
//        }
//        
        cappuccinoImageView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(Constants.DRINK_IMAGE_SIZE)
            make.centerX.equalTo(view.center)
            make.top.equalTo(coffeeImageView.snp.bottom).offset(Constants.DRINK_IMAGE_PADDING)
        }
        
//        cappuccinoLabel.snp.makeConstraints { (make) -> Void in
//            make.centerX.equalTo(cappuccinoImageView.center)
//            make.top.equalTo(cappuccinoImageView.snp.bottom).offset(Constants.DRINK_LABEL_PADDING)
//        }
        
        hotchocolateImageView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(Constants.DRINK_IMAGE_SIZE)
            make.centerX.equalTo(view.center)
            make.top.equalTo(cappuccinoImageView.snp.bottom).offset(Constants.DRINK_IMAGE_PADDING)
        }
        
//        hotchocolateLabel.snp.makeConstraints { (make) -> Void in
//            make.centerX.equalTo(hotchocolateImageView.center)
//            make.top.equalTo(hotchocolateImageView.snp.bottom).offset(Constants.DRINK_LABEL_PADDING)
//        }
        
        
    }

}

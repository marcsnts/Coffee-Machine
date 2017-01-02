//
//  CoffeeMachineRequests.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2017-01-01.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import Foundation
import Alamofire

extension NetworkRequest {
    
    class func postOrder(order: [String: Any]) {
        
        guard let postOrderRequest = createRequest(requestType: .POST, url: Constants.POST_ENDPOINT, data: order) else {
            return
        }
        
        Alamofire.request(postOrderRequest).responseJSON { response in
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }
    
}

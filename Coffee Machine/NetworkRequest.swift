//
//  NetworkRequest.swift
//  Coffee Machine
//
//  Created by Marc Santos on 2017-01-01.
//  Copyright © 2017 Marc Santos. All rights reserved.
//

import Foundation

enum NetworkRequestType: String {
    case POST = "POST",
    GET = "GET",
    PUT = "PUT"
}

class NetworkRequest {
    
    class func createRequest(requestType: NetworkRequestType, url: String, data: [String:Any]?) -> URLRequest? {
        
        guard let url = URL(string: url) else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        
        //Set header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = data {
            do {
                request.httpBody  = try JSONSerialization.data(withJSONObject: data, options: [])
            }
            catch {
                print("[ERROR]Could not serialize body to JSON")
            }
        }
        
        return request
    }

}

//
//  ServiceLayer.swift
//  Nagaw
//
//  Created by Ragaie Alfy on 3/11/19.
//  Copyright © 2019 Ragaie Alfy. All rights reserved.
//

import Foundation
import UIKit
public enum HTTPWay : String{
    case GET = "GET"
    case POST = "POST"
    
}
open class CHNetwork: NSObject {
    static let shared = CHNetwork()
    var headers : [String:String] = [:]
    
    override init() {
        super.init()
    }
    
    
    
    
    
    
    //MARK : get data with json reponse.
    open func requestJson(requestWay : HTTPWay,bodyParameter : Data? = nil ,urlString : String,Loader : Bool , result: @escaping (Data?,URLResponse?,Error?)->Void){
        let url = URL(string:urlString)
        let session = URLSession.shared
        var request = URLRequest(url: url!)
        request.httpMethod = requestWay.rawValue
        
        if bodyParameter != nil {
            
            request.httpBody = bodyParameter
        }
        for (key,value) in headers{
            request.setValue(value, forHTTPHeaderField: key)
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
     
        
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
           
                DispatchQueue.main.async {
                    result(data, response, error)
                    
                    ///Update ui indecator
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                 
                }
           
        }
        task.resume()
    }

}




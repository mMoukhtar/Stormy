//
//  NetworkOperations.swift
//  Stormy
//
//  Created by Mohamed Moukhtar on 5/12/16.
//  Copyright © 2016 Mohamed Moukhtar. All rights reserved.
//

import Foundation


class NetworkOperations {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    typealias JSonDictionaryType = ([String: AnyObject])? -> Void
    let url: NSURL
    
    init (url: NSURL) {
        self.url = url
    }
    
    func downloadJsonFromURL(completion: JSonDictionaryType) {
        let request = NSURLRequest(URL: self.url)
        let dataTask = self.session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            // 1. Check for successful response
            if let httpResponse = response as? NSHTTPURLResponse  {
                switch httpResponse.statusCode {
                case 200:
                    //Parse Json
                    do {
                        let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                        completion(jsonDict)
                    } catch (let error) {
                        print(error)
                        completion(nil)
                    }
                case 400: print("Bad Request")
                case 401: print("Unauthorized")
                case 402: print("Payment Required")
                case 403: print("Forbidden")
                case 404: print("Not Found")
                default: print(httpResponse.statusCode)
                }
                
            } else {
                print("Invalid response")
            }
            
        }
        dataTask.resume()
    }

    
}





















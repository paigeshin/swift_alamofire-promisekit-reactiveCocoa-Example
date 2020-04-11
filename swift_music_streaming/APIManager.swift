//
//  APIManager.swift
//  swift_music_streaming
//
//  Created by shin seunghyun on 2020/04/11.
//  Copyright © 2020 shin seunghyun. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

class APIManager {
    
    static let api = APIManager()
    
    private init() {
        
    }
    
    func fetchData(url: String) -> Promise<[String]> {
        
        return Promise {
            resolver in
            
            AF.request(BASE_URL).responseString {
                response in
                
                switch(response.result) {
                    
                case .success(let data):
                    resolver.fulfill([""])
                    print("my actual response in :-", data)
                case .failure(let error):
                    resolver.reject(error)
                    print(error)
                    
                }
                
            }
        }
        
    }
    
}

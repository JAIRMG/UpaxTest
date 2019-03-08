//
//  ApiService.swift
//  UpaxPrueba
//
//  Created by Jair Moreno Gaspar on 3/7/19.
//  Copyright © 2019 Jair Moreno Gaspar. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    func fetchForUrlString(urlString: String, completion: @escaping (User) -> ()) {
        
        
        let todoEndpoint: String = urlString
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        urlRequest.httpMethod = "GET"
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                
                guard let user = try? JSONDecoder().decode(User.self, from: data) else {
                    print("Error al parsear")
                    return
                }
                
                DispatchQueue.main.async {
                    completion(user)
                }
                
            }
        }
        task.resume()
        
    }
    
    
    
}


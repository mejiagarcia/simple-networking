//
//  ViewController.swift
//  Example
//
//  Created by Luis Carlos Mejia Garcia on 2/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import UIKit
import SimpleNetworking

/*
 Models here for example purposes
 */

struct User: Codable {
    let title: String
    let userId: Int
}

struct ServerError: Codable {
    let error: String
    let serverError: String
}

/*
 End
*/


class ViewController: UIViewController {
    
    @IBOutlet weak var humanNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        SimpleNetworking.debugMode = .all
        
        getMyData()
        getDataWithError()
        postData()
    }
    
    // MARK: - GET Examples

    private func getMyData() {
        // 1. Prepare your endpoint.
        let endpoint = "https://jsonplaceholder.typicode.com/todos/1"
        
        // 2. Make the request
        SN.get(endpoint: endpoint) { [weak self] (response: SNResult<User>) in
            
            switch response {
            case .error(let error):
                // 3. Hanlde the possible error.
                print(error.localizedDescription)
                
            case .success(let response):
                // 4. Enjoy
                self?.humanNameLabel.text = response.title
            }
        }
    }
    
    private func getDataWithError() {
        // Endpoint with 404 response and error.
        let endpoint = "http://www.mocky.io/v2/5de68cd33700005a000924a4"
        
        SN.get(endpoint: endpoint) { (response: SNResultWithEntity<User, ServerError>) in
            
            switch response {
                
            // Regular error
            case .error(let error):
                print(error.localizedDescription)
                
            // Error parsed to your error entity
            case .errorResult(let entity):
                print(entity.error)
                print(entity.serverError)
                
            // Regular success
            case .success(let response):
                print(response.title)
            }
        }
    }
    
    // MARK: - POST Methods
    
    private func postData() {
        // 1. Prepare your endpoint.
        let endpoint = "https://jsonplaceholder.typicode.com/posts"
        
        // 2. Prepare your request
        let request = User(title: "test title", userId: 99999)
        
        // 2. Make the request
        SN.post(endpoint: endpoint, model: request) { [weak self] (response: SNResult<User>) in
            
            switch response {
            case .error(let error):
                // 3. Hanlde the possible error.
                print(error.localizedDescription)
                
            case .success(let response):
                // 4. Enjoy
                self?.humanNameLabel.text = response.title
            }
        }
    }
}


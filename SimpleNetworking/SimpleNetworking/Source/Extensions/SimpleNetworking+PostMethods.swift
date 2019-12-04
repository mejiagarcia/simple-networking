//
//  SimpleNetworking+PostMethods.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 3/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

// MARK: - POST Methods
extension SimpleNetworking {
    
    public static func post<T: Codable>(endpoint: String,
                                        model: Codable? = nil,
                                        onCompletion: SNResultBlock<T>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        let request = Requests.getCreatedRequest(url: url, model: model, method: .post)
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                Thread.main { onCompletion?(.error(error: .custom(error: error))) }
                
                return
            }
            
            guard SimpleNetworkingValidator.isValidStatusCode(response: response) else {
                Thread.main { onCompletion?(.error(error: .badResponse)) }
                
                return
            }
            
            guard let serviceData = data else {
                Thread.main { onCompletion?(.error(error: .emptyContent)) }
                
                return
            }
            
            do {
                let entity: T = try SimpleNetworking.decoder.decode(T.self, from: serviceData)
                
                Thread.main { onCompletion?(.success(response: entity)) }
                
            } catch let error {
                Thread.main { onCompletion?(.error(error: .custom(error: error))) }
            }
        }
        
        SimpleNetworking.currentTask?.resume()
    }
    
    public static func post<T: Codable, Y: Codable>(endpoint: String,
                                                    model: Codable? = nil,
                                                    onCompletion: SNResultBlockWithError<T, Y>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        let request = Requests.getCreatedRequest(url: url, model: model, method: .post)
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                Thread.main { onCompletion?(.error(error: .custom(error: error))) }
                
                return
            }
            
            guard let serviceData = data else {
                Thread.main { onCompletion?(.error(error: .emptyContent)) }
               
               return
           }
            
            if !SimpleNetworkingValidator.isValidStatusCode(response: response) {
                do {
                    let errorEntity: Y = try SimpleNetworking.decoder.decode(Y.self, from: serviceData)
                    
                    Thread.main { onCompletion?(.errorResult(entity: errorEntity)) }
                } catch let error {
                    Thread.main { onCompletion?(.error(error: .custom(error: error))) }
                }
                
                return
            }
            
            do {
                let entity: T = try SimpleNetworking.decoder.decode(T.self, from: serviceData)
                Thread.main { onCompletion?(.success(response: entity)) }
                
            } catch let error {
                Thread.main { onCompletion?(.error(error: .custom(error: error))) }
            }
        }
        
        SimpleNetworking.currentTask?.resume()
    }
}

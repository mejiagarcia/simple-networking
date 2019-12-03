//
//  SimpleNetworking.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 2/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

public class SimpleNetworking {
    // MARK: - Properties
    public static var currentTask: URLSessionTask?
    public static let decoder = JSONDecoder()
    public static let session = URLSession.shared
}

// MARK: - Public Methods
extension SimpleNetworking {
    public static func stop() {
        SimpleNetworking.currentTask?.cancel()
    }
    
    public static func get<T: Codable>(endpoint: String, onCompletion: SNResultBlock<T>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: url) {
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
    
    public static func get<T: Codable, Y: Codable>(endpoint: String, onCompletion: SNResultBlockWithError<T, Y>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: url) {
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

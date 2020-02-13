//
//  SimpleNetworking.swift
//  SimpleNetworking
//
//  Created by Luis Carlos Mejia Garcia on 2/12/19.
//  Copyright © 2019 Mejia Garcia. All rights reserved.
//

import Foundation

public enum SNDebugMode {
    case onlyRequests
    case onlyResponses
    case all
    case disabled
}

public class SimpleNetworking {
    // MARK: - Properties
    public static var currentTask: URLSessionTask?
    public static let decoder = JSONDecoder()
    public static let session = URLSession.shared
    public static var debugMode: SNDebugMode = .disabled
    
    public static var defaultHeaders: NSMutableDictionary = [
        "Content-Type": "application/json"
    ]
    
    // MARK: - Public Methods
    public static func stop() {
        SimpleNetworking.currentTask?.cancel()
    }
    
    public static func setAuthenticationHeader(prefix: String, token: String) {
        SimpleNetworking.defaultHeaders["Authorization"] = "\(prefix) \(token)"
    }
}

// MARK: - Data Request Methods
extension SimpleNetworking {
    
    static func dataRequestWithCustomResult<T: Codable, Y: Codable>(endpoint: String,
                                                                    model: Codable? = nil,
                                                                    method: RequestMethodTypes,
                                                                    onCompletion: SNResultBlockWithError<T, Y>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        let request = Requests().getCreatedRequest(url: url, model: model, method: method)
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            DebugMode.printResult(response: response, resultData: data)
            
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
    
    static func dataRequest<T: Codable>(endpoint: String,
                                        model: Codable? = nil,
                                        method: RequestMethodTypes,
                                        onCompletion: SNResultBlock<T>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        let request = Requests().getCreatedRequest(url: url, model: model, method: method)
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            DebugMode.printResult(response: response, resultData: data)
            
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
}

// MARK: - Simple Request Methods
extension SimpleNetworking {
    static func request<T: Codable>(endpoint: String,
                                    method: RequestMethodTypes,
                                    onCompletion: SNResultBlock<T>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        let request = Requests().getCreatedRequest(url: url, method: method)
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            DebugMode.printResult(response: response, resultData: data)
            
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
    
    static func requestWithCustomResult<T: Codable, Y: Codable>(endpoint: String,
                                                                method: RequestMethodTypes,
                                                                onCompletion: SNResultBlockWithError<T, Y>) {
        
        guard let url = URL(string: endpoint) else {
            Thread.main { onCompletion?(.error(error: .endpoint)) }
            
            return
        }
        
        let request = Requests().getCreatedRequest(url: url, method: method)
        
        SimpleNetworking.currentTask = SimpleNetworking.session.dataTask(with: request) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            DebugMode.printResult(response: response, resultData: data)
            
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

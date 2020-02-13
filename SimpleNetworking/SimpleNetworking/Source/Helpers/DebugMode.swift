//
//  DebugMode.swift
//  SimpleNetworking
//
//  Created by Carlos Mejía on 12/02/20.
//  Copyright © 2020 Mejia Garcia. All rights reserved.
//

import Foundation

struct DebugMode {
    static func printRequest(_ request: URLRequest) {
        
        guard SimpleNetworking.debugMode == .all || SimpleNetworking.debugMode == .onlyRequests else { return }
        
        print("**** REQUEST ****")
        print("ENDPOINT:")
        print(" - " + (request.url?.absoluteString ?? ""))
        print("METHOD:")
        print(" - " + (request.httpMethod ?? ""))
        print("HEADERS:")
        request.allHTTPHeaderFields?.enumerated().forEach {
            print(" - [\($0.offset + 1)] \($0.element.key):\($0.element.value)")
        }
        
        if request.httpBody != nil {
            print("OBJECT SENT:")
            print(dataToJSON(data: request.httpBody))
        }
        
        print("**** END OF REQUEST ****")
        
        print("")
        print("")
        print("")
    }
    
    static func printResult(response: URLResponse?, resultData: Data?) {
        
        guard SimpleNetworking.debugMode == .all || SimpleNetworking.debugMode == .onlyResponses,
            let urlResponse = response as? HTTPURLResponse else { return }
        
        print("**** RESPONSE ****")
        print("ENDPOINT:")
        print("- " + (urlResponse.url?.absoluteString ?? ""))
        print("OBJECT:")
        print(dataToJSON(data: resultData))
        print("HEADERS:")
        urlResponse.allHeaderFields.enumerated().forEach {
            print(" - [\($0.offset + 1)] \($0.element.key):\($0.element.value)")
        }
        print("STATUS CODE:")
        print(" - " + "\(urlResponse.statusCode)")
        print("**** END OF RESPONSE ****")
        
        print("")
        print("")
        print("")
    }
    
    static func dataToJSON(data: Data?) -> String {
        guard let data = data else { return "" }
        
        return (NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?) ?? ""
    }
}

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
        
        print("[ℹ️][\(getCurrentTime())] REQUEST")
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
        
        print("[ℹ️] END OF REQUEST")
        
        print("")
        print("")
        print("")
    }
    
    static func printResult(response: URLResponse?, resultData: Data?) {
        
        guard SimpleNetworking.debugMode == .all || SimpleNetworking.debugMode == .onlyResponses,
            let urlResponse = response as? HTTPURLResponse else { return }
        
        let isValidStatusCode = (200 ... 299 ~= urlResponse.statusCode)
        let symbol = isValidStatusCode ? "✅" : "❌"
        
        print("[\(symbol)][\(getCurrentTime())] RESPONSE")
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
        print("[\(symbol)] END OF RESPONSE")
        
        print("")
        print("")
        print("")
    }
    
    static func dataToJSON(data: Data?) -> String {
        guard let data = data else { return "" }
        
        return (NSString(data: data, encoding: String.Encoding.utf8.rawValue) as String?) ?? ""
    }
}

private func getCurrentTime() -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    
    return formatter.string(from: Date())
}

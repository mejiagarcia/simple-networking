//
//  URLSessionPinningDelegate.swift
//  SimpleNetworking
//
//  Created by Carlos Mejía on 5/03/20.
//  Copyright © 2020 Mejia Garcia. All rights reserved.
//

import Foundation
import Security

class URLSessionPinningDelegate: NSObject, URLSessionDelegate {
    
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            
            return
        }
        
        guard let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            
            return
        }
        
        //set ssl polocies for domain name check
        let policies = NSMutableArray()
        policies.add(SecPolicyCreateSSL(true, challenge.protectionSpace.host as CFString))
        SecTrustSetPolicies(serverTrust, policies)
        
        //evaluate server certifiacte
        guard var result: SecTrustResultType = SecTrustResultType(rawValue: 0) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            
            return
        }
        
        SecTrustEvaluate(serverTrust, &result)
        let isServerTrusted: Bool = (result == SecTrustResultType.unspecified || result == SecTrustResultType.proceed)
        
        //get Local and Remote certificate Data
        
        let remoteCertificateData: NSData =  SecCertificateCopyData(certificate)
        
        guard
            let pathToCertificate = SSLConfig.certificatePath,
            let localCertificateData: NSData = NSData(contentsOfFile: pathToCertificate) else {
                completionHandler(.cancelAuthenticationChallenge, nil)
                
                return
        }
        
        //Compare certificates
        if(isServerTrusted && remoteCertificateData.isEqual(to: localCertificateData as Data)) {
            let credential = URLCredential(trust:serverTrust)
            completionHandler(.useCredential, credential)
        }
        else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}

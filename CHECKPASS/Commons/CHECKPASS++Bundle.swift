//
//  CHECKPASS++Bundle.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/31/24.
//

import Foundation

extension Bundle {
    //MARK: - Public IP Address
    var publicIP: String {
        guard let file = self.path(forResource: "CHECKPASSInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let publicIP = resource["PublicIP"] as? String else {
            return ""
        }
        
        return publicIP
    }
    
    //MARK: - Domain HTTPS Address
    var domain: String {
        guard let file = self.path(forResource: "CHECKPASSInfo", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let domain = resource["Domain"] as? String else {
            return ""
        }
        
        return domain
    }
}

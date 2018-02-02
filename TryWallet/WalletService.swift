//
//  WalletService.swift
//  TryWallet
//
//  Created by Sergey Alyasev on 02/02/2018.
//  Copyright © 2018 Convergent Media Group. All rights reserved.
//

import Foundation
import PassKit

struct WalletPassData {
    let phone: String?
    let card: String?
}

class WalletService {
    
    private var passLibrary: PKPassLibrary
    private var userPass: PKPass?
    
    var isPassExist: Bool {
        return tryFindPass()
    }
    
    init?() {
        guard PKPassLibrary.isPassLibraryAvailable() else {
            print("Pass Library is not available")
            return nil
        }
        
        passLibrary = PKPassLibrary()
    }
    
    private func tryFindPass() -> Bool {
        let passes: [PKPass] = passLibrary.passes(of: .barcode)
        print("passes count: \(passes.count)")
        
        guard !passes.isEmpty else {
            return false
        }
        
        for pass in passes {
            // take the first
            if pass.organizationName == "CMG" {
                userPass = pass
                return true
            }
        }
        
        return false
    }
    
    func readPass() -> WalletPassData {
        return WalletPassData(phone: userPass?.localizedValue(forFieldKey: "phone_number") as? String,
                              card: userPass?.localizedValue(forFieldKey: "card_number") as? String)
    }
    
    func openPass() {
        // go to cart in wallet
        if let url = userPass?.passURL,
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
}

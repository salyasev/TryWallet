//
//  ViewController.swift
//  TryWallet
//
//  Created by Sergey Alyasev on 02/02/2018.
//  Copyright © 2018 Convergent Media Group. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var cardField: UITextField!
    
    fileprivate let walletService = WalletService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passCheck()
    }

    @IBAction func openInWallet(_ sender: Any) {
        walletService?.openPass()
    }
    
    func passCheck() {
        guard let walletService = walletService else {
            return
        }
        
        if walletService.isPassExist {
            let alert = UIAlertController(title: "Найдена дисконтная карта", message: "Использовать для входа?", preferredStyle: UIAlertControllerStyle.alert)
            
            let yesAction = UIAlertAction(title: "Да", style: UIAlertActionStyle.default, handler: { (action) in
                let walletPassData = walletService.readPass()
                self.fillIn(with: walletPassData)
            })
            alert.addAction(yesAction)
            
            let noAction = UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel, handler: { (action) in
                // do nothing
            })
            alert.addAction(noAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    private func fillIn(with walletPass: WalletPassData) {
        self.phoneField.text = walletPass.phone
        self.cardField.text = walletPass.card
    }
}


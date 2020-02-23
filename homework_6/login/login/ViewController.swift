//
//  ViewController.swift
//  login
//
//  Created by Nan Ni on 2/19/20.
//  Copyright © 2020 Nan Ni. All rights reserved.
//

import UIKit
import shibauthframework2019

class ViewController: UIViewController {
    let alertController = LoginAlert(title: "Authenticate", message: nil, preferredStyle: .alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        alertController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.present(alertController, animated: true, completion: nil)
    }
}


extension ViewController: LoginAlertDelegate {
    
    func onSuccess(_ loginAlertController: LoginAlert, didFinishSucceededWith status: LoginResults, netidLookupResult: NetidLookupResultData?, netidLookupResultRawData: Data?, cookies: [HTTPCookie]?, lastLoginTime: Date) {
        // succeeded, extract netidLookupResult.id and netidLookupResult.password for your server credential
        // other properties needed for homework are also in netidLookupResult
        print("\( netidLookupResult?.id ?? "")")
        print("\( netidLookupResult?.email ?? "")")
        
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "toMyTable", sender: self)
        }
    }
    
    func onFail(_ loginAlertController: LoginAlert, didFinishFailedWith reason: LoginResults) {
        // when authentication fails, this method will be called.
        // default implementation provided
    }
    
    func inProgress(_ loginAlertController: LoginAlert, didSubmittedWith status: LoginResults) {
        // this method will get called for each step in progress.
        // default implementation provided
    }
    
    func onLoginButtonTapped(_ loginAlertController: LoginAlert) {
        // the login button on the alert is tapped
        // default implementation provided
    }

    func onCancelButtonTapped(_ loginAlertController: LoginAlert) {
        // the cancel button on the alert is tapped
        // default implementation provided
    }
}

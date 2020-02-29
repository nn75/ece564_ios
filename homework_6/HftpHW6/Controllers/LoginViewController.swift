//
//  LoginViewController.swift
//  HftpHW6
//
//  Created by Nan Ni on 2/23/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit
import shibauthframework2019


var CurrentUserData : NetidLookupResultData?

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    let alertController = LoginAlert(title: "Authenticate", message: nil, preferredStyle: .alert)
    var onSuccessAlertController = UIAlertController()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        alertController.delegate = self
        
        playTitleLabelAnimation()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func playTitleLabelAnimation() {
        titleLabel.text = ""
        var charIndex = 0.0
        let titleText = "⚡️ECE564⚡️"
        for letter in titleText {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}


extension LoginViewController: LoginAlertDelegate {
    
    func onSuccess(_ loginAlertController: LoginAlert, didFinishSucceededWith status: LoginResults, netidLookupResult: NetidLookupResultData?, netidLookupResultRawData: Data?, cookies: [HTTPCookie]?, lastLoginTime: Date) {
        // succeeded, extract netidLookupResult.id and netidLookupResult.password for your server credential
        print("\(netidLookupResult?.id ?? "")")
        CurrentUserData = netidLookupResult
        let httprequest = urlGET(true, nil, self)
        DispatchQueue.main.sync {
            httprequest.resume()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.onSuccessAlertController.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func onFail(_ loginAlertController: LoginAlert, didFinishFailedWith reason: LoginResults) {
        // when authentication fails, this method will be called.
        Alert.loginFailedAlert(on: self, message: reason.description)
    }
    
    func inProgress(_ loginAlertController: LoginAlert, didSubmittedWith status: LoginResults) {
        // this method will get called for each step in progress.
        playTitleLabelAnimation()
    }
    
    func onLoginButtonTapped(_ loginAlertController: LoginAlert) {
        // the login button on the alert is tapped
        onSuccessAlertController =  Alert.loginInProgressAlert(on: self, message: "It takes a while...")
    }

    func onCancelButtonTapped(_ loginAlertController: LoginAlert) {
        // the cancel button on the alert is tapped
    }
}


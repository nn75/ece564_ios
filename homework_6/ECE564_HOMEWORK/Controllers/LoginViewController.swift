//
//  LoginViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/23/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit
import shibauthframework2019

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    let alertController = LoginAlert(title: "Authenticate", message: nil, preferredStyle: .alert)
    
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
        // other properties needed for homework are also in netidLookupResult
        print("\(netidLookupResult?.id ?? "")")
        
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: K.loginSegue, sender: self)
        }
    }
    
    func onFail(_ loginAlertController: LoginAlert, didFinishFailedWith reason: LoginResults) {
        // when authentication fails, this method will be called.
        // default implementation provided
        let alert = UIAlertController(title: "Login Failed", message: reason.description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func inProgress(_ loginAlertController: LoginAlert, didSubmittedWith status: LoginResults) {
        // this method will get called for each step in progress.
        // default implementation provided
        playTitleLabelAnimation()
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


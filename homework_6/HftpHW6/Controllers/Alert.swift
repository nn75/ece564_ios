//
//  Alert.swift
//  HftpHW6
//
//  Created by Nan Ni on 2/27/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

struct Alert {
    
    //Alert title
    static let loginFailedAlertTitle = "Login Failed"
    static let loadFailedAlertTitle = "Load Failed"
    static let saveFailedAlertTitle = "Save Failed"
    static let saveSuccessAlertTitle = "Save Success"
    static let loginInProgressAlertTitle = "Authenticating"
    static let postFailedAlertTitle = "Post Failed"
    
    //Alert format
    static func showAlert(on vc: UIViewController, title: String, message: String, with action: Alert.Action) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(action.alertAction)
        DispatchQueue.main.async {
            vc.present(alertController, animated: true, completion: nil)
        }
        return alertController
    }
    
    //Alert: login in progress alert
    static func loginInProgressAlert(on vc: UIViewController, message: String) -> UIAlertController {
        return showAlert(on: vc, title: loginInProgressAlertTitle, message: message, with: Action.loginAuthentication)
    }
    
    //Alert: login failure alert
    static func loginFailedAlert(on vc: UIViewController, message: String) {
        let _ = showAlert(on: vc, title:loginFailedAlertTitle,  message: message, with: Action.loginFailed)
    }
    
    //Alert: load failure alert
    static func loadFailedAlert(on vc: UIViewController, message: String) {
        let _ = showAlert(on: vc, title: loadFailedAlertTitle, message: message, with: Action.loadFailed)
    }
    
    //Alert: save failure alert
    static func saveFailedAlert(on vc: UIViewController, message: String){
        let _ = showAlert(on: vc, title: saveFailedAlertTitle, message: message, with: Action.saveFailed)
    }
    
    //Alert: save success alert
    static func saveSuccessAlert(on vc: UIViewController, message: String, actions: Alert.Action) {
        let _ = showAlert(on: vc, title: saveSuccessAlertTitle, message: message, with: actions)
    }
    
    //Alert: post failure alert
    static func postFailedAlert(on vc: UIViewController, message: String){
        let _ = showAlert(on: vc, title: postFailedAlertTitle, message: message, with: Action.saveFailed)
    }
    
}





extension Alert {
    
    //Alert button title
    static var OKButtonTitle = "OK"
    
    enum Action {
        case saveSuccess(handler: (() -> Void)?)
        case saveFailed
        case loginFailed
        case loginAuthentication
        case loadFailed
        case postFailed
        
        private var alertButtonTitle: String {
            switch self {
            case .saveSuccess:
                return OKButtonTitle
            case .saveFailed:
                return OKButtonTitle
            case .loginFailed:
                return OKButtonTitle
            case .loginAuthentication:
                return OKButtonTitle
            case .loadFailed:
                return OKButtonTitle
            case .postFailed:
                return OKButtonTitle
            }
            
            
            
        }
        
        // Returns the completion handler of our button
        private var handler: (() -> Void)? {
            switch self {
            case .saveSuccess(let handler):
                return handler
            case .saveFailed:
                return nil
            case .loginFailed:
                return nil
            case .loginAuthentication:
                return nil
            case .loadFailed:
                return nil
            case .postFailed:
                return nil
            }
        }
        
        var alertAction: UIAlertAction {
            return UIAlertAction(title: alertButtonTitle, style: .default, handler: { _ in
                if let handler = self.handler {
                    handler()
                }
            })
        }
    }
    
}

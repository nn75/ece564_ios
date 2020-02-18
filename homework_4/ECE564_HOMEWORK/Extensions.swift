//
//  Extensions.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/2/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

//MARK: - Dismiss keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        /* Dismiss keyboard by touching anywhere
         Reference: https://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
         */
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
}


//MARK: - Rotate UIView
extension UIView {
    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.layer.add(animation, forKey: nil)
    }

}

//MARK: - Change appearance of UITextField
extension UITextField {
    func isDisabled(_ state: Bool){
        self.isUserInteractionEnabled = state
        self.textColor = state ? UIColor.black : UIColor(named: K.BrandColors.gray)
    }
}


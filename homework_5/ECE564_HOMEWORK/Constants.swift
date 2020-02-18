//
//  Constants.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/6/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import Foundation
import UIKit


struct K {
    static let photoSize = CGSize(width: 100, height: 100)
    static let scaleSize: CGFloat = 0.8
    
    static let cellIdentifier = "personCell"
    static let cellNibName = "PersonTableViewCell"
    static let headerIdentifier = "header"
    static let editSegue = "goToPersonInfo"
    static let addSegue = "goToAddPerson"
    static let saveBackSegue = "saveBackToTable"
    static let category = ["All", "MS", "BS", "MENG", "PHD", "NA", "Other"]
    
    struct BrandColors {
        static let darkBlue = "BrandDarkBlue"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
        static let milkyWhite = "BrandMilkyWhite"
        static let gray = "BrandGray"
    }
}


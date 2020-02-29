//
//  Constants.swift
//  HftpHW6
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
    static let animateCellIdentifier = "animateCell"
    static let cellNibName = "PersonTableViewCell"
    static let headerIdentifier = "header"
    static let loginSegue = "goToTableView"
    static let editSegue = "goToPersonInfo"
    static let addSegue = "goToAddPerson"
    static let nanAniSegue = "goToNanAni"
    static let niboAniSegue = "goToNiboAni"
    static let kaiAniSegue = "goToKaiAni"
    static let zihuiAniSegue = "goToZihuiAni"
    static let saveBackSegue = "saveBackToTable"
    
    struct BrandColors {
        static let darkBlue = "BrandDarkBlue"
        static let blue = "BrandBlue"
        static let lightBlue = "BrandLightBlue"
        static let milkyWhite = "BrandMilkyWhite"
        static let gray = "BrandGray"
        static let cellBlue = "BrandCellBlue"
    }
    
    struct HobbyColors {
        static let niboBlue = "NiboHobbyBlue"
    }
    
    struct HobbyViews {
        static let niboVC = "NiboHobbyViewController"
        static let nanVC = "HobbyViewController"
        static let kaiVC = "KaiHobbyViewController"
        static let zihuiVC = "ZihuiHobbyViewController"
    }
}


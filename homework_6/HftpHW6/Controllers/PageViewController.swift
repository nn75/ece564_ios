//
//  PageViewController.swift
//  HftpHW6
//
//  Created by Nan Ni on 2/9/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource  {
    var personFullName = ""
    
    lazy var subViewControllers: [UIViewController] = {
        // first append default NavigationViewController
        var vcArray: [UIViewController] = [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "first") as! NavigationViewController]
        
        // append team member's unique animation view controller
        switch personFullName {
        case "Nan Ni" :
            vcArray.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "second") as! HobbyViewController)
        case "Nibo Ying" :
            vcArray.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.HobbyViews.niboVC) as! NiboHobbyViewController)
        case "Kai Wang" :
            vcArray.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.HobbyViews.kaiVC) as! KaiHobbyViewController)
        case "Zihui Zheng" :
            vcArray.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.HobbyViews.zihuiVC) as! ZihuiHobbyViewController)
        default:
            break
        }
        return vcArray
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pvc = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal)
        pvc.dataSource = self
        self.addChild(pvc)
        self.view.addSubview(pvc.view)
        pvc.view.frame = self.view.bounds
        pvc.didMove(toParent: self)
        
        pvc.setViewControllers([subViewControllers[0]], direction: .forward, animated: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        return currentIndex <= 0 ? nil : subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = subViewControllers.firstIndex(of: viewController) ?? 0
        return currentIndex >= subViewControllers.count - 1 ? nil : subViewControllers[currentIndex + 1]
    }
    
}

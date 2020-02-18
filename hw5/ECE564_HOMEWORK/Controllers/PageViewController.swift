//
//  PageViewController.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/9/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, UIPageViewControllerDataSource  {
    var hasTravelHobby = false
    
    lazy var subViewControllers: [UIViewController] = {
        if (hasTravelHobby) {
            return [
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "first") as! NavigationViewController,
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "second") as! HobbyViewController
            ]
        } else {
            return [
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "first") as! NavigationViewController,
            ]
        }
        
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

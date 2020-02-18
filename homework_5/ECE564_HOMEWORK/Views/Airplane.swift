//
//  Airplane.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/9/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class Airplane: UIView {
    
    override func draw(_ rect: CGRect) {
        var path: UIBezierPath!
        path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 0))
        let pencilDot: [[Int]] = [[80,20],[80,60],[0,130],[0,150],[80,90],[80,130],[98,200],
                                  [100,200],[102,200],[120,130],[120,90],[200,150],[200,130],[120,60],[120,20]]
        for point in pencilDot {
            path.addLine(to: CGPoint(x: point[0], y: point[1]))
        }
        
        path.close()
        let r = UIGraphicsImageRenderer(size:CGSize(width: 6,height: 6))
        let stripes = r.image {
            ctx in
            let imcon = ctx.cgContext
            imcon.setFillColor(UIColor.black.cgColor)
            imcon.fill(CGRect(x: 0, y: 0, width: 6, height: 10))
            imcon.setFillColor(UIColor.gray.cgColor)
            imcon.fill(CGRect(x: 0, y: 0, width: 6,height: 3))
            imcon.setFillColor(UIColor.white.cgColor)
            imcon.fill(CGRect(x: 0,y: 0, width: 6, height: 1))
        }
        
        let stripesPattern = UIColor(patternImage:stripes)
        stripesPattern.setFill()
        //UIColor.black.setFill()
        path.fill()
    }
}

//
//  PrairieScene.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/9/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class Prairie: UIView {
    override class var layerClass : AnyClass {
        return PrairieLayer.self
    }
    
}

class PrairieLayer : CALayer, CALayerDelegate {
    var tail : CALayer?
    override func layoutSublayers() {
        self.setBackgroundAndBody()
    }
    
    func setBackgroundAndBody() {
        let bg = CAGradientLayer()
        bg.contentsScale = UIScreen.main.scale
        bg.frame = CGRect(x: 0, y: 550, width: 400, height: 300)
        bg.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor,
        ]
        bg.locations = [0.0,0.1]
        self.addSublayer(bg)
        
        let gazelle = CAShapeLayer()
        gazelle.contentsScale = UIScreen.main.scale
        gazelle.lineWidth = 2.0
        gazelle.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        gazelle.strokeColor = UIColor.black.cgColor
        let path = CGMutablePath.init()
        path.move(to: CGPoint(x: 40, y: 627))
        let gl: [[Int]] = [[36, 611],[34, 600],[27, 577],[29, 553],[44, 535],[69, 525],[84, 527],[99, 521],[112, 528],[121, 538],[147, 548],[143, 541],[157, 551],[161, 547],[173, 555],[175, 536],[173, 524],[173, 517],[178, 530],[182, 541],[180, 518],[188, 532],[189, 550],[180, 569],[171, 594],[167, 613],[160, 617],[154, 612],[153, 596],[146, 584],[131, 584],[120, 589],[115, 611],[116, 626],[101, 627],[97, 611],[94, 597],[71, 601],[60, 626],[47, 626],[54, 603],[48, 596],[45, 623],[44, 627]]
        for point in gl {
            path.addLine(to: CGPoint(x: point[0] + 175, y: (point[1] - 58)))
        }
        path.move(to: CGPoint(x: 277, y: 627))
        gazelle.path = path
        self.addSublayer(gazelle)
        let text = CATextLayer()
        text.contentsScale = UIScreen.main.scale
        text.string = String("") // Add text later
        text.fontSize = 18
        text.bounds = CGRect(x: 10,y: 0, width: 300, height: 40)
        text.position = CGPoint(x: 130, y: 500)
        text.alignmentMode = CATextLayerAlignmentMode.center
        text.foregroundColor = UIColor.white.cgColor
        self.addSublayer(text)
        
        let tail = CALayer()
        tail.contentsScale = UIScreen.main.scale
        tail.bounds = CGRect(x: 0, y: 0, width: 50, height: 120)
        tail.anchorPoint = CGPoint(x: 1, y: 1)
        tail.position = CGPoint(x: 27 + 175, y: 577 - 58)
        tail.delegate = self
        self.addSublayer(tail)
        tail.setNeedsDisplay()
        self.tail = tail
        self.swayTail()
        
    }
    
    func swayTail(duration: Double = 3) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        if let tail = self.tail {
            tail.add(rotateAnimation, forKey: "rotateViewAnimation")
        }
    }
    
    func draw(_ layer: CALayer, in con: CGContext) {
        con.move(to: CGPoint(x: 20, y: 120))
        con.addLine(to: CGPoint(x: 25, y: 118))
        con.addLine(to: CGPoint(x: 50, y: 120))
        con.closePath()
        con.setLineWidth(10)
        con.setStrokeColor(UIColor.black.cgColor)
        con.strokePath()
    }
}

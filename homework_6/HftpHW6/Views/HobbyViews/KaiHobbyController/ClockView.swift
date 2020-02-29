//
//  ClockView.swift
//  HftpHW6
//
//  Created by Kai Wang on 2/25/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    var center : CGPoint {
        return CGPoint(x:self.midX, y:self.midY)
    }
}

class ClockView: UIView {
      override class var layerClass : AnyClass {
            return ClockLayer.self
        }

    }

    class ClockLayer : CALayer, CALayerDelegate {
        var hand : CALayer?

        override func layoutSublayers() {
            self.setup()
        }

        /*  This drawing has 2 sublayers in the view.  They get painted in this order:
         - The circle, which is the face of the compass, and uses CAShapeLayer
         - The hand, which is a CALayer we draw ourselves.
         */

        func setup () {
            // Draw the dial on the clock
            let circle = CAShapeLayer()
            circle.contentsScale = UIScreen.main.scale
            circle.lineWidth = 2.0
            circle.fillColor = UIColor(red:0.8, green:0.8, blue:0.8, alpha:0.6).cgColor
            circle.strokeColor = UIColor.gray.cgColor
            let p = CGMutablePath()
            p.addEllipse(in: self.bounds.insetBy(dx: 3, dy: 3))
            circle.path = p
            self.addSublayer(circle)
            circle.bounds = self.bounds
            circle.position = .zero

            // Place the hour hand on the clock
            let hand = CALayer()
            hand.contentsScale = UIScreen.main.scale
            hand.bounds = CGRect(x: 0, y: 0, width: 50, height: 120)
            hand.position = .zero
            hand.anchorPoint = CGPoint(x: 0.5, y: 0.9)
            hand.delegate = self

            self.addSublayer(hand)
            hand.setNeedsDisplay()
            self.hand = hand
            self.handRotate360(duration: 1)
        }

        func handRotate360(duration: Double = 5) {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(Double.pi * 2)
            rotateAnimation.isRemovedOnCompletion = false
            rotateAnimation.duration = duration
            rotateAnimation.repeatCount = Float.infinity
            if let hand = self.hand {
                hand.add(rotateAnimation, forKey: "rotateViewAnimation")
            }
        }

        func draw(_ layer: CALayer, in con: CGContext) {


            // draw the vertical line, add its shape to the clipping region
            con.move(to: CGPoint(x: 0, y: 120))
            con.addLine(to: CGPoint(x: 0, y: 90))
            con.setLineWidth(10)
            con.setStrokeColor(UIColor.blue.cgColor)
            con.strokePath()


        }
    }

class tvDraw: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    //Draw a tv graphics
    override func draw(_ rect: CGRect) {
        let p = UIBezierPath()
        p.lineWidth = 5.0
        p.move(to: CGPoint(x: 0, y: 0))
        p.addLine(to: CGPoint(x: self.frame.width - 10, y: 0))
        p.addLine(to: CGPoint(x: self.frame.width - 10, y: 80))
        p.addLine(to: CGPoint(x: 0, y: 80))
        p.close()
        
        UIColor.black.setStroke()
        p.stroke()
        
        let tvImage = UIImageView()
        tvImage.frame = CGRect(x: 5, y: 5, width: self.frame.width - 20, height: 70)
        tvImage.image = UIImage(named: "Game.jpg")
        self.addSubview(tvImage)
    }
}

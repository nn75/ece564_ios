//
//  HobbyViewController.swift
//  HftpHW6
//
//  Created by Nan Ni on 2/9/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit
import AVFoundation

class HobbyViewController: UIViewController {
    var bgmPlayer: AVAudioPlayer = AVAudioPlayer()
    
    var moveAlongPath: CAAnimation!
    var sun: UIView = Sun()
    var colorView = UIView()
    var treeView = UIImageView()
    var cloudViews = [UIImageView]()
    let sloganLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 56, y: 360, width: 280, height: 100)
        label.isHidden = true
        label.text = "Welcome to Africa!"
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 30)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpGraphic()
        addBgm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addAnimations()
        bgmPlayer.play()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        bgmPlayer.stop()
    }
    
    func setUpGraphic() {
        addSun()
        addTree()
        addSlogan()
        setPrairieLayerView()
        setButtonView()
    }
    
    func addAnimations() {
        animateClouds()
        animateSun()
    }
    
    func addBgm() {
        do {
            bgmPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "GoToNgoroNgoro", ofType: "mp3")!))
        } catch {
            print(error)
        }
    }
    
    func setButtonView() {
        let airplainButton = UIButton()
        airplainButton.frame = CGRect(x: 270, y: 10, width: 100, height: 40)
        airplainButton.backgroundColor = UIColor.clear
        airplainButton.setTitle("Airplane", for: .normal)
        airplainButton.setTitleColor(UIColor(named: K.BrandColors.blue), for: .normal)
        airplainButton.addTarget(self, action: #selector(HobbyViewController.animateAirplanePressed(_:)), for: .touchUpInside)
        view.addSubview(airplainButton)
    }
    
    func addSlogan() {
        view.addSubview(sloganLabel)
    }
    
    @objc func animateAirplanePressed(_ sender: UIButton!) {
        addAirplane()
    }
    
    func addAirplane() {
        let airLine: UIView = Airplane()
        airLine.frame = CGRect(x: 50, y: 200, width: 200, height: 200)
        airLine.backgroundColor = UIColor.clear
        self.view.addSubview(airLine)
    
        let originalCenter = airLine.center
        let animatorShrink = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) { [airLine] in
            airLine.transform = CGAffineTransform(rotationAngle: 0).scaledBy(x: 0.1, y: 0.1)
        }
        let animatorEnlarge = UIViewPropertyAnimator(duration: 3, curve: .easeInOut) { [airLine] in
            airLine.center = originalCenter
            airLine.transform = CGAffineTransform(rotationAngle: 0).scaledBy(x: 0.8, y: 0.8)
        }
        let animatorMove = UIViewPropertyAnimator(duration: 9, curve: .easeOut) {
            airLine.center =  CGPoint(x: 150, y: -400)
            self.sloganLabel.isHidden = false
        }
        animatorShrink.startAnimation()
        airLine.self.isHidden = true
    
        animatorShrink.addCompletion { _ in
            animatorShrink.stopAnimation(true)
            animatorEnlarge.startAnimation()
            animatorMove.startAnimation()
            airLine.self.isHidden = false

        }
    
        animatorEnlarge.addCompletion { _ in
            self.sloganLabel.isHidden = true
            animatorEnlarge.stopAnimation(true)
            airLine.removeFromSuperview()
            animatorEnlarge.stopAnimation(true)
            airLine.removeFromSuperview()
        }
    }
    
    
    func addTree() {
        treeView.image = UIImage(named: "Tree")
        treeView.frame = CGRect(x: -170, y: 210, width: 700, height: 600)
        treeView.contentMode = .scaleAspectFit
        view.addSubview(treeView)
    }
    
    func addSun() {
        colorView.frame = CGRect(x: 0, y: 0, width: 375, height: 580)
        colorView.backgroundColor = #colorLiteral(red: 0.03222545981, green: 0.02074555866, blue: 0.009296458215, alpha: 0.8953230574)
        view.addSubview(colorView)
        
        sun = Sun(frame: CGRect(x: -40, y: 600, width: 150, height: 150))
        view.addSubview(sun)
    }

    
    func animateSun() {
        colorView.backgroundColor = #colorLiteral(red: 0.03222545981, green: 0.02074555866, blue: 0.009296458215, alpha: 0.8953230574)
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .autoreverse],
                       animations: {
                        self.colorView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }, completion: { _ in
          self.colorView.backgroundColor = #colorLiteral(red: 0.03222545981, green: 0.02074555866, blue: 0.009296458215, alpha: 0.8953230574)
        })
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -50, y: 400))
        path.addQuadCurve(to: CGPoint(x: 450, y: 400), controlPoint: CGPoint(x: 250, y: 10) )

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 1.0
        self.view.layer.addSublayer(shapeLayer)
        
        let moveAlongPath = CAKeyframeAnimation(keyPath: "position")
        moveAlongPath.path = path.cgPath
        moveAlongPath.duration = 10
        moveAlongPath.repeatCount = HUGE
        moveAlongPath.calculationMode = CAAnimationCalculationMode.paced
        moveAlongPath.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)]
        self.moveAlongPath = moveAlongPath

        let sunLayer = sun.layer
        sunLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        sunLayer.position = CGPoint(x: -40, y: 400)
        sunLayer.add(moveAlongPath, forKey: "animate along Path")
    }
    
    func animateClouds() {
        let iv1 = UIImageView()
        let iv2 = UIImageView()
        let iv3 = UIImageView()
        cloudViews += [iv1, iv2, iv3]
        
        for i in 0 ..< cloudViews.count {
            cloudViews[i].frame = CGRect(x: -380 - i*300, y: -80 + i*40, width: 400, height: 400)
            cloudViews[i].image = UIImage(named: "Cloud")
            cloudViews[i].alpha = 0.5
            cloudViews[i].contentMode = .scaleAspectFit
            self.view.addSubview(cloudViews[i])
        }
        
        for i in 0 ..< cloudViews.count {
            UIView.animate(withDuration: 15, delay: TimeInterval(i*2),
                           options: [.repeat, .curveEaseIn],
                           animations: {
                            self.cloudViews[i].center.x = self.view.frame.width + self.cloudViews[i].bounds.width / 2 + 150
            },completion: nil)
            
        }
    }
    
    
    func setPrairieLayerView() {
        let prairie = Prairie()
        prairie.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view?.addSubview(prairie)
    }
}

//
//  NiboHobbyViewController.swift
//  HftpHW6
//
//  Created by student on 2/24/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit
import AVFoundation

let gunCocking = Bundle.main.url(forResource: "Gun_cocking", withExtension: "mp3")
let gunShot = Bundle.main.url(forResource: "Gun_shot", withExtension: "mp3")
var audioPlayer = AVAudioPlayer()

class NiboHobbyViewController: UIViewController {

    var shouldPlaySound = false
    
    @IBOutlet weak var textView: UIView!
    @IBOutlet weak var aimingBlack: UIImageView!
    @IBOutlet weak var sunImageView: UIImageView!
    // @IBOutlet weak var aquamanImageView: UIImageView!
    @IBOutlet weak var gunImageView: UIImageView!
    @IBOutlet weak var openFireButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: Any) {
        redAmingAnimation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawSun()
        drawTextView()
        self.view.backgroundColor = UIColor(named: K.HobbyColors.niboBlue)
    }
    
    /*
     A customized text field will pop up at the end of the animation
     */
    func drawTextView(){
        let textLayer = CATextLayer()
        textLayer.frame = self.textView.bounds
        textLayer.string = "Misson Complete"
        textLayer.font = CTFontCreateWithName("Chalkduster" as CFString, 1.0 , nil)
        textLayer.foregroundColor = UIColor.black.cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = CATextLayerAlignmentMode.left
        textLayer.contentsScale = UIScreen.main.scale
        self.textView.layer.addSublayer(textLayer)
        self.textView.isHidden = true
    }
    
    /*
     another Drawing
     */
    func drawSun() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))
        let img = renderer.image { ctx in
            let sun = CGRect(x: 5, y: 5, width: 240, height: 240)
            ctx.cgContext.setFillColor(UIColor.systemYellow.cgColor)
            ctx.cgContext.addEllipse(in: sun)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        sunImageView.image = img
    }
    
    /*
     reset all the status to restart the animation
     */
    override func viewWillAppear(_ animated: Bool) {
        self.shouldPlaySound = true
        self.openFireButton.isHidden = true
        self.textView.isHidden = true
        self.aimingBlack.image = UIImage(named: "Aiming_black")
        startBlackAimingAnimation()
    }
    
    /*
     stop all sound when view is disappearing
     */
    override func viewDidDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        self.shouldPlaySound = false
    }
    
    /*
     first animation, move aiming icon to the enemy
     */
    func startBlackAimingAnimation(){
        UIView.animate(withDuration: 1.5, delay: 0 ,options: [], animations: {
            self.aimingBlack.frame.origin.x += 100
        }, completion: { (finished: Bool) in
            UIView.animate(withDuration: 1.5, delay: 0 ,options: [], animations: {
                self.aimingBlack.frame.origin.x -= 100
            }, completion: { (finished: Bool) in
                if self.shouldPlaySound {
                    self.aimingBlack.image = UIImage(named: "Aiming_red")
                    self.playSound(url: gunCocking!)
                    self.openFireButton.isHidden = false
                }
                })
            })
    }
    
    /*
     aiming locked in, waiting for Open Fire command
     */
    func redAmingAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0 ,options: [UIView.AnimationOptions.autoreverse], animations: {
            self.playSound(url: gunShot!)
            self.gunImageView.center.y -= 10
            self.gunImageView.center.x += 10
        }, completion: { (finished: Bool) in
            self.aimingBlack.image = UIImage(named: "Dead_emoji")
            self.textView.isHidden = false
        })
    }
    
    func playSound(url: URL){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print("couldn't load sound file")
        }
    }

}

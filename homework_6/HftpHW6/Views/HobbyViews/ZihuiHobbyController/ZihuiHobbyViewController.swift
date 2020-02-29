//
//  ZihuiHobbyViewController.swift
//  HftpHW6
//
//  Created by Zihui on 2/24/20.
//  Copyright © 2020 ECE564. All rights reserved.
//


import UIKit
import AVFoundation

class ZihuiHobbyViewController: UIViewController {

    /// the component sof the animation
    let athelete = UIImageView()
    let barbell = UIImageView()
    let fan = UIImageView()
    var musicPlayer : AVAudioPlayer = AVAudioPlayer()
    var muteBtn = UIButton()
    
    // this function controls the animation of bench pressing
    // barbell will move up and down
    func moveBarbell(){
        self.barbell.frame.origin.y = 300
        UIView.animate(withDuration: 1, delay: 0,
                       options: [.repeat, .autoreverse], animations: {
                        self.barbell.frame.origin.y += 25
        })
    }
    
    // this function controls the animation of fan rotating
    func rotateFan(){
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
           rotation.toValue = Double.pi/2
           rotation.duration = 0.25 // or however long you want ...
           rotation.isCumulative = true
           rotation.repeatCount = Float.greatestFiniteMagnitude
           fan.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    // using this function to create an UIbutton
    func ButtonCreator(xIn:Int, yIn:Int, textIn:String) -> UIButton {
           let newDukeButton = UIButton.init(frame: CGRect(x:xIn,y:yIn, width:100,height:50))
           newDukeButton.setTitle(textIn, for: UIControl.State.normal)
           newDukeButton.setTitleColor(UIColor.black, for: UIControl.State.normal)//button text color
           newDukeButton.backgroundColor = .clear
           newDukeButton.layer.cornerRadius = 5
           newDukeButton.layer.borderWidth = 1
           newDukeButton.layer.borderColor = UIColor.black.cgColor
           return newDukeButton
       }

    // initialize the music player and "Mute" button
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
        let session = AVAudioSession.sharedInstance()
        muteBtn = ButtonCreator(xIn: 260, yIn: 520,textIn: "Mute")
        muteBtn.addTarget(self, action: #selector(addMute(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(muteBtn)
        do{
            try session.setActive(true)
            try session.setCategory(AVAudioSession.Category.playback)
            UIApplication.shared.beginReceivingRemoteControlEvents()
            let path = Bundle.main.path(forResource: "gym_music", ofType: "mp3")
            let soundUrl = URL(fileURLWithPath: path!)
            try musicPlayer = AVAudioPlayer(contentsOf: soundUrl)
            musicPlayer.prepareToPlay()
            musicPlayer.volume = 1.0
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch{
            print(error)
        }
    }
    
    //change the status of button
    @objc func addMute(_ sender: UIButton) {
        if muteBtn.titleLabel!.text == "Mute"{
            musicPlayer.stop()
            muteBtn.setTitle("Unmute", for: .normal)
        } else{
            musicPlayer.play()
            muteBtn.setTitle("Mute", for: .normal)
        }
    }
    
    // initialize the bench press animation
    // and draw the speaker using vector graphic drawing
    func configureView() {
        athelete.image = UIImage(named: "athelete.png")
        barbell.image = UIImage(named: "barbell.png")
        fan.image = UIImage(named: "fan.png")
        athelete.frame = CGRect(x: 0, y: 300, width: 200, height: 200)
        barbell.frame = CGRect(x: 0, y: 300, width: 200, height: 200)
        fan.frame = CGRect(x: 200, y: 100, width: 100, height: 100)
        self.view.addSubview(athelete)
        self.view.addSubview(barbell)
        self.view.addSubview(fan)
        let speakerFrame = CGRect(x: 250, y: 340, width:90, height: 140)
        UIGraphicsBeginImageContextWithOptions(speakerFrame.size, false, 0.0)
        let color: UIColor = UIColor.black
        let outterFrame: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 10, y: 10, width: 70, height: 120), cornerRadius: 10)
        outterFrame.lineWidth = 10
        color.set()
        outterFrame.stroke()
        let color2: UIColor = UIColor(red: 204/255, green: 204/255, blue: 1, alpha: 1)
        color2.set()
        outterFrame.fill()
        let upCircle1 : UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 25, y: 15, width: 40, height: 40), cornerRadius: 40)
        let downCircle1 : UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 20, y: 75, width: 50, height: 50), cornerRadius: 50)
        let upCircle2 : UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 37, y: 27, width: 16, height: 16), cornerRadius: 16)
        let downCircle2 : UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 35, y: 90, width: 20, height: 20), cornerRadius: 20)
        upCircle1.lineWidth = 10
        downCircle1.lineWidth = 10
        upCircle2.lineWidth = 10
        downCircle2.lineWidth = 10
        color.set()
        upCircle1.stroke()
        downCircle1.stroke()
        let color3: UIColor = UIColor(red: 153/255, green: 255/255, blue: 204/255, alpha: 1)
        color3.set()
        upCircle1.fill()
        downCircle1.fill()
        color.set()
        upCircle2.stroke()
        downCircle2.stroke()
        let color4 : UIColor = UIColor.white
        color4.set()
        upCircle2.fill()
        downCircle2.fill()
        let saveImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        let iv = UIImageView()
        iv.frame = speakerFrame
        iv.image = saveImage
        self.view.addSubview(iv)
    }
    
    // when filp to this page, play the music, reset the button
    // and start the animation
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        musicPlayer.play()
        muteBtn.setTitle("Mute", for: .normal)
        moveBarbell()
        rotateFan()
    }
    
    // when flip to other pages, stop the music
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        musicPlayer.stop()
    }

}

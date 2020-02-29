//
//  KaiHobbyViewController.swift
//  HftpHW6
//
//  Created by student on 2/24/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit
import AVFoundation
// extension to String object
extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.white.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 30)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

class KaiHobbyViewController: UIViewController {
    var mainView: UIView!
    var audioPlayer:AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainView = self.view
        let tv: UIView = tvDraw()
        setPeopleGS()
        tv.frame = CGRect(x: 150, y: 200, width: 200, height: 150)
        tv.backgroundColor = UIColor.white
        mainView.addSubview(tv)
        
        playBackgroundMusic()
    }
    
    // MARK: Graphic Set
     func setPeopleGS() {
         let path = UIBezierPath()
         path.move(to: CGPoint(x: 100, y: 290))
         path.addLine(to: CGPoint(x: 100, y: 360))
         path.move(to: CGPoint(x: 100, y: 320))
         path.addLine(to: CGPoint(x: 70, y: 340))
         path.move(to: CGPoint(x: 100, y: 320))
         path.addLine(to: CGPoint(x: 130, y: 340))
         path.move(to: CGPoint(x: 100, y: 360))
         path.addLine(to: CGPoint(x: 120, y: 380))
         path.move(to: CGPoint(x: 100, y: 360))
         path.addLine(to: CGPoint(x: 80, y: 380))
         let shapeLayer1 = CAShapeLayer()
         shapeLayer1.path = path.cgPath
         shapeLayer1.strokeColor = UIColor.gray.cgColor
         shapeLayer1.lineWidth = 2.0
         mainView.layer.addSublayer(shapeLayer1)
         
         let iav = UIImageView()
         let i: [UIImage] = ["🥰".image()!, "🙄".image()!, "😭".image()!, "😡".image()!]
         iav.frame = CGRect(x: 80, y: 270, width: 50, height: 50)
         iav.animationImages = i
         iav.animationDuration = 4
         iav.startAnimating()
         mainView.addSubview(iav)
         
         let lv = ClockView()
         lv.frame = CGRect(x: 120, y: 120, width: 100, height: 100)
         view?.addSubview(lv)
     }
     override func viewDidDisappear(_ animated: Bool) {
         audioPlayer.stop()
     }
     
     override func viewDidAppear(_ animated: Bool) {
         audioPlayer.play()
     }
    
     //MARK: Action
     func playBackgroundMusic() {
         let session = AVAudioSession.sharedInstance()
         do{
             try session.setActive(true)
             
             try session.setCategory(AVAudioSession.Category.playback)
             UIApplication.shared.beginReceivingRemoteControlEvents()
             
             let path = Bundle.main.path(forResource: "game_music", ofType: "mp3")
             let soudUrl = URL(fileURLWithPath: path!)
             try audioPlayer = AVAudioPlayer(contentsOf: soudUrl)
             audioPlayer.prepareToPlay()
             audioPlayer.volume = 1.0
             audioPlayer.numberOfLoops = -1
             } catch{
                 print(error)
             }
       }
     
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

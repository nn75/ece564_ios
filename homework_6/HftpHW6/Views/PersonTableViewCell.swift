//
//  PersonTableViewCell.swift
//  HftpHW6
//
//  Created by Nan Ni on 1/31/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var personDescription: UILabel!
    var hasAnimation = false
    
    var personInCell: DukePerson? {
        didSet{
            self.updateCell()
        }
    }
    
    func updateCell() {
        photoView.layer.masksToBounds = true
        photoView.layer.cornerRadius = photoView.bounds.width / 2
        
        let name = (personInCell?.firstName)! + " " + (personInCell?.lastName)!
        fullName.text = name
        personDescription.text = personInCell?.description
        
        if let safePersonInCell = personInCell {
            if let safeImage = safePersonInCell.picture.base64ToImage() {
                photoView.image = safeImage
            } else {
                photoView.image = UIImage(named: "No photo")
            }
        } else {
            print("Cell display error")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func animateAvatar(){
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping:1, initialSpringVelocity:0.5, options: .curveEaseIn ,animations: {
            
            self.photoView.transform = CGAffineTransform(scaleX: 3, y: 3)
            self.photoView.transform = CGAffineTransform(translationX: +8, y: 0)
            
        })
        { (_) in
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping:1,initialSpringVelocity:2, options: .curveEaseIn ,animations: {

                self.photoView.transform = CGAffineTransform(scaleX: 1, y:1)

            },completion: nil)
        }
    }
    
}

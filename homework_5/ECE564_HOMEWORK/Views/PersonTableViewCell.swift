//
//  PersonTableViewCell.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 1/31/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var personDescription: UILabel!
    
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
            photoView.image = safePersonInCell.picture.base64ToImage()
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
    
}

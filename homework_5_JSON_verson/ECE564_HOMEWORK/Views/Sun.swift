//
//  Sun.swift
//  ECE564_HOMEWORK
//
//  Created by Nan Ni on 2/10/20.
//  Copyright © 2020 ECE564. All rights reserved.
//

import UIKit

class Sun: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    func setUpView() {
        let image = UIImage(named: "Sun.png")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

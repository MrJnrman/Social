//
//  RoundButton.swift
//  Social
//
//  Created by Jamel Reid  on 4/30/17.
//  Copyright © 2017 Jamel Reid . All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GREY, green: SHADOW_GREY, blue: SHADOW_GREY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        layer.cornerRadius = 5.0
        imageView?.contentMode = .scaleAspectFit
    }
    
    
    // make the button a circle
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        layer.cornerRadius = self.frame.width / 2
//    }

}

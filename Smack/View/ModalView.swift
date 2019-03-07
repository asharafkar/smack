//
//  ModalView.swift
//  Smack
//
//  Created by Amir on 3/2/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

@IBDesignable
class ModalView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView(){
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        self.prepareForInterfaceBuilder()
        setupView()
    }
    
}

//
//  AvatarCell.swift
//  Smack
//
//  Created by Amir on 2/27/19.
//  Copyright © 2019 Amir Sharafkar. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func configureCell(index: Int, type: AvatarType){
        switch type {
        case .dark:
            image.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        case .light:
            image.image = UIImage(named: "light\(index)")
             self.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
    
    func setupView(){
        self.layer.backgroundColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}

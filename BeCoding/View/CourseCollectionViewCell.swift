//
//  CourseCollectionViewCell.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    
 
    @IBOutlet weak var imageCollectionCell: UIImageView!
    @IBOutlet weak var descriptionLabelCollectionCell: UILabel!
    @IBOutlet weak var userImageView: UIImageView!  {
        didSet {
            userImageView.layer.borderColor = UIColor.systemBackground.cgColor
            userImageView.layer.borderWidth = 1.0
            userImageView.layer.cornerRadius = userImageView.frame.size.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
//            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
//            userImageView.addGestureRecognizer(tabGesture)
        }
    }
    
    @IBOutlet weak var nameLabelCollectionCell: UILabel! {
        didSet{
            nameLabelCollectionCell.layer.masksToBounds = true
            nameLabelCollectionCell.layer.cornerRadius = 20
        }
    }
    
    
    func configure(with courses:Course) -> UICollectionViewCell {
        nameLabelCollectionCell.text = courses.title
        descriptionLabelCollectionCell.text = courses.description
        userImageView.loadImageUsingCache(with: courses.user.imageUrl)
        imageCollectionCell.loadImageUsingCache(with: courses.imageUrl)
        return self
    }
    override func prepareForReuse() {
        self.imageCollectionCell.image = nil
        self.userImageView.image = nil

    }
}

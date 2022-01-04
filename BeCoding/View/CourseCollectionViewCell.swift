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
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabelCollectionCell: UILabel!
    
    
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

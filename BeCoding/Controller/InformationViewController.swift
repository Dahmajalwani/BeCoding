//
//  InformationViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import UIKit

class InformationViewController: UIViewController {
   
    var selectedCourse:Course?
    var selectedCourseImage:UIImage?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    @IBOutlet weak var userLangugeLabel: UILabel!
    @IBOutlet weak var userInstructionLabel: UILabel!
    @IBOutlet weak var userDataAddLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedCourse = selectedCourse,
        let selectedCourseImage = selectedCourseImage{
            userImageView.image = selectedCourseImage
            userTitleLabel.text = selectedCourse.name
            userDescriptionLabel.text = selectedCourse.description
//            userLangugeLabel.text = selectedCourse.languages
//            userInstructionLabel.text = selectedCourse.instruction
//            userDataAddLabel.text = selectedCourse.dataAdd
          
        }
    }
}

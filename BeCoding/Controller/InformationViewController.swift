//
//  InformationViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import UIKit

class InformationViewController: UIViewController {
    var selectedUser:User?
    var selectedUserImage:UIImage?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userTitleLabel: UILabel!
    @IBOutlet weak var userDescriptionLabel: UILabel!
    @IBOutlet weak var userLangugeLabel: UILabel!
    @IBOutlet weak var userInstructionLabel: UILabel!
    @IBOutlet weak var userDataAddLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedUser = selectedUser,
        let selectedUserImage = selectedUserImage{
            userImageView.image = selectedUserImage
            userTitleLabel.text = selectedUser.title
            userDescriptionLabel.text = selectedUser.description
            userLangugeLabel.text = selectedUser.languages
            userInstructionLabel.text = selectedUser.instruction
            userDataAddLabel.text = selectedUser.dataAdd
          
        }
    }
}

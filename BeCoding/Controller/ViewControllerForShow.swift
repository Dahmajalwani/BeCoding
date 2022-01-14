//
//  ViewControllerForShow.swift
//  BeCoding
//
//  Created by dahma alwani on 07/06/1443 AH.
//

import Foundation
import UIKit
// this for show details in this view controller

class ViewControllerForShow: UIViewController{
    
    @IBOutlet weak var viewHidder: UIView!
    {
        didSet{
            viewHidder.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            viewHidder.layer.borderWidth = 0
            viewHidder.layer.cornerRadius = 20
            viewHidder.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            viewHidder.layer.masksToBounds = true
            viewHidder.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var topicTitle: UILabel!

    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var describeTitle: UILabel!

    var selectedItem:Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = selectedItem {
            topicTitle.text = item.theName
            describeTitle.text = item.theDetails
            imageView.image = UIImage(named: item.theImage)
    }
    }
}

//
//  ViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 23/05/1443 AH.
//

import UIKit

class LandingViewController: UIViewController {

    override func viewDidLoad() {super.viewDidLoad()}
//    Language change
    @IBAction func langugeSegment(_ sender: Any){
//      didSet {
//            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
//                switch lang {
//           case "EN":
//                    langugeSegment.selectedSegmentIndex = 1
//                case "AR":
//                    langugeSegment.selectedSegmentIndex = 0
//                default:
//                    let localLang =  Locale.current.languageCode
//                     if localLang == "EN" {
//                         langugeSegment.selectedSegmentIndex = 1
//                     }else{
//                         langugeSegment.selectedSegmentIndex = 0
//                     }
//                }
//           }else{
//                let localLang =  Locale.current.languageCode
//                 if localLang == "EN" {
//                     langugeSegment.selectedSegmentIndex = 1
//                 } else{
//                     langugeSegment.selectedSegmentIndex = 0
//                 }
//            }
//                }
            }
    
    @IBOutlet weak var JoinToUsToBecomePartOfViosion2030: UILabel! {
        didSet {
            JoinToUsToBecomePartOfViosion2030.text = "JoinToUsToBecomePartOfViosion2030".localized
        }
    }
}
    extension String {
        var localized: String {
            return NSLocalizedString(self, tableName: "localaziable", bundle: .main, value: self, comment: self)
        }

}


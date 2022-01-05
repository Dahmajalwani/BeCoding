

import UIKit

class LandingViewController: UIViewController {

//    Language change
    @IBOutlet weak var langugeSegment: UISegmentedControl! {
            
            didSet{
                if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
                    switch lang {
                    case "ar":
                        langugeSegment.selectedSegmentIndex = 0
                    case "en":
                        langugeSegment.selectedSegmentIndex = 1
                    default:
                        let localLang =  Locale.current.languageCode
                         if localLang == "en" {
                             langugeSegment.selectedSegmentIndex = 1
                         }else {
                             langugeSegment.selectedSegmentIndex = 0
                         }
                      
                    }
                
                }else {
                    let localLang =  Locale.current.languageCode
                    UserDefaults.standard.setValue([localLang], forKey: "AppleLanguages")
                     if localLang == "en" {
                         langugeSegment.selectedSegmentIndex = 1
                     } else {
                         langugeSegment.selectedSegmentIndex = 0
                     }
                }
            }
        }
        
        @IBOutlet weak var programmersDeveloperButton: UIButton! {
            didSet{
                programmersDeveloperButton.setTitle(NSLocalizedString("Programmers/Developer", tableName: "Localizable", comment: ""),for: .normal)
            }
        }
        @IBOutlet weak var JoinToUsToBecomePartOfViosion2030: UILabel! {
            didSet {
                JoinToUsToBecomePartOfViosion2030.text = "JoinToUsToBecomePartOfViosion2030".localized
            }
        }
        
        @IBOutlet weak var registerLabel: UILabel! {
            
            didSet {
                registerLabel.text = "RegisterAs".localized
            }
        }
        
        @IBOutlet weak var newRegisterButton: UIButton! {
            didSet {
                newRegisterButton.setTitle(NSLocalizedString("New", tableName: "Localizable", comment: ""),for: .normal)
            }
        }
        override func viewDidLoad() {
            super.viewDidLoad()

          
        }
        
        
        @IBAction func actionsegmentLanguge(_ sender: UISegmentedControl) {
            if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
                if lang == "ar" {
                             UIView.appearance().semanticContentAttribute = .forceRightToLeft
                         }else {
                             UIView.appearance().semanticContentAttribute = .forceLeftToRight
                         }
                
                        UserDefaults.standard.set(lang, forKey: "currentLanguage")
                        Bundle.setLanguage(lang)
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let sceneDelegate = windowScene.delegate as? SceneDelegate {
                            sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
                        }
            }

        }
            
    }
    extension String {
           
            var localized: String {
                return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
            }
    }

    
    
//    @IBOutlet var langugeSegment: UISegmentedControl!
//    {
//        didSet {
//            if let lang = UserDefaults.standard.string(forKey: "currentLanguage") {
//                switch lang {
//                case "en":
//                    langugeSegment.selectedSegmentIndex = 1
//                case "ar":
//                    langugeSegment.selectedSegmentIndex = 0
//                default:
//                    let localLang =  Locale.current.languageCode
//                     if localLang == "en" {
//                         langugeSegment.selectedSegmentIndex = 1
//                     }else{
//                         langugeSegment.selectedSegmentIndex = 0
//                     }
//                }
//           }else{
//                let localLang =  Locale.current.languageCode
//               UserDefaults.standard.setValue(localLang, forKey: "AppleLanguages")
//                 if localLang == "en" {
//                     langugeSegment.selectedSegmentIndex = 1
//                 } else{
//                     langugeSegment.selectedSegmentIndex = 0
//                 }
//            }
//                }
//            }
//
//    @IBAction func langugeChange(_ sender: UISegmentedControl) {
//        if let lang = sender.titleForSegment(at:sender.selectedSegmentIndex)?.lowercased() {
//            if lang == "ar" {
//                UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            }else {
//                UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            }
//            UserDefaults.standard.set(lang, forKey: "currentLanguage")
//            Bundle.setLanguage(lang)
//            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let sceneDelegate = windowScene.delegate as? SceneDelegate {
//                sceneDelegate.window?.rootViewController = storyboard.instantiateInitialViewController()
//            }
//        }
//    }
//
//    @IBOutlet weak var JoinToUsToBecomePartOfViosion2030: UILabel! {
//        didSet {
//            JoinToUsToBecomePartOfViosion2030.text = "JoinToUsToBecomePartOfViosion2030".localized
//        }
//    }
//    @IBOutlet weak var registerLabel: UILabel! {
//        didSet{
//        registerLabel.text = "RegisterAs".localized
//    }
//}
//    @IBOutlet weak var newRegisterButton: UIButton!
//    {
//        didSet {
//            newRegisterButton.setTitle(NSLocalizedString("New", tableName: "localizable" , comment : ""), for: .normal)
//        }
//    }
//    override func viewDidLoad() {super.viewDidLoad()}
//
//    @IBOutlet weak var programmerDeveloperRegisterButton: UIButton!
//    {
//        didSet {
//            programmerDeveloperRegisterButton.setTitle(NSLocalizedString("Programmers/Developer", tableName: "localizable" , comment : ""), for: .normal)
//        }
//    }
//}
//    extension String {
//        var localized: String {
//            return NSLocalizedString(self, tableName: "localizable", bundle: .main, value: self, comment: self)
//        }
//
//}
//

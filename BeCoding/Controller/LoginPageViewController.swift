//
//  LoginPageViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 24/05/1443 AH.
//

import UIKit
import Firebase
class LoginPageViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var signInLabel: UILabel!
    {
        didSet {
            signInLabel.text = "SignIn".localized
        }
    }
    @IBOutlet weak var welcomLabel: UILabel!
    {
        didSet {
            welcomLabel.text = "welcome".localized
        }
    }
    @IBOutlet weak var emailLabelSignin: UILabel!
    {
        didSet {
            emailLabelSignin.text = "Email".localized
        }
    }
    @IBOutlet weak var passwordLabel: UILabel!
    {
        didSet {
            passwordLabel.text = "Password".localized
        }
    }
    @IBOutlet weak var signInButton: UIButton!
    {
        didSet {
            signInButton.setTitle(NSLocalizedString("SignIn", tableName: "Localizable", comment: ""),for: .normal)
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet{
            passwordTextField.isSecureTextEntry = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func signButton(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let _ = authResult {
                    if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CourseNavigationController") as? UINavigationController {
                        vc.modalPresentationStyle = .fullScreen
                        Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    
}

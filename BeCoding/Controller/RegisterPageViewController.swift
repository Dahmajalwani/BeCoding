//
//  RegisterPageViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 24/05/1443 AH.
//


import UIKit
import Firebase
class RegisterPageViewController: UIViewController {
    
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
    @IBOutlet weak var signUpLable: UILabel!
    {
        didSet {
            signUpLable.text = "SignUp".localized
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    {
        didSet {
            nameLabel.text = "Name".localized
        }
    }
    @IBOutlet weak var emailLabel: UILabel!
    {
        didSet {
            emailLabel.text = "Email".localized
        }
    }
    @IBOutlet weak var passwordLabel: UILabel!
    {
        didSet {
            passwordLabel.text = "Password".localized
        }
    }
    @IBOutlet weak var passwordConfLabel: UILabel!
    {
        didSet {
            passwordConfLabel.text = "PasswordCon".localized
        }
    }
    
    @IBOutlet weak var continueButtonOutlit: UIButton!
    {
        didSet {
            continueButtonOutlit.setTitle(NSLocalizedString("Continue", tableName: "Localizable", comment: ""),for: .normal)
        }
    }
    
    @IBOutlet weak var eyePass: UIButton!
    
    @IBOutlet weak var eyepasss: UIButton!
    
    @IBAction func eyePas(_ sender: UIButton) {
            passwordTextField.isSecureTextEntry.toggle()
            if passwordTextField.isSecureTextEntry {
                if let image = UIImage(systemName: "eye.fill") {
                    sender.setImage(image, for: .normal)
                }
            } else {
                if let image = UIImage(systemName: "eye.slash.fill"){
                    sender.setImage(image, for: .normal)
                }
            }
        }
        
        @IBAction func changePasswordVisibility(_ sender: UIButton) {
            confirmPasswordTextField.isSecureTextEntry.toggle()
            if confirmPasswordTextField.isSecureTextEntry {
                if let image = UIImage(systemName: "eye.fill") {
                    sender.setImage(image, for: .normal)
                }
            } else {
                if let image = UIImage(systemName: "eye.slash.fill"){
                    sender.setImage(image, for: .normal)
                }
            }
        }
    
    let imagePickerController = UIImagePickerController()
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var userImageView: UIImageView! {
        didSet {
            userImageView.layer.borderColor = UIColor.systemGray2.cgColor
            userImageView.layer.borderWidth = 1.0
            userImageView.layer.cornerRadius = userImageView.frame.size.height / 2
            userImageView.layer.masksToBounds = true
            userImageView.isUserInteractionEnabled = true
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
            userImageView.addGestureRecognizer(tabGesture)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    {
        didSet{
            nameTextField.placeholder = "yourName".localized
        }
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    {
        didSet{
            emailTextField.placeholder = "youEmailAddress".localized
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet{
            passwordTextField.isSecureTextEntry = true
            passwordTextField.placeholder = "enterPassoword".localized
        }
    }
    
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet{
            confirmPasswordTextField.isSecureTextEntry = true
            confirmPasswordTextField.placeholder = "enterPassowordCon".localized
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "backButton".localized, style: .plain, target: nil, action: nil)
        imagePickerController.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        passwordTextField.rightView = eyePass
        passwordTextField.rightViewMode = .whileEditing
               
        confirmPasswordTextField.rightView = eyepasss
        confirmPasswordTextField.rightViewMode = .whileEditing
    }
    
    @IBAction func registerButtonToContinue(_ sender: Any) {
        
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let name = nameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = confirmPasswordTextField.text,
           password == confirmPassword {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
            Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                    print("Registration Auth Error",error.localizedDescription)
                }
                if let authResult = authResult {
                    let storageRef = Storage.storage().reference(withPath: "users/\(authResult.user.uid)")
                    let uploadMeta = StorageMetadata.init()
                    uploadMeta.contentType = "image/jpeg"
                    storageRef.putData(imageData, metadata: uploadMeta) { storageMeta, error in
                        if let error = error {
                            Alert.showAlert(strTitle: "Error", strMessage: error.localizedDescription, viewController: self)
                         Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            print("Registration Storage Error",error.localizedDescription)
                        }
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                print("Registration Storage Download Url Error",error.localizedDescription)
                                
                            }
                            if let url = url {
                                print("URL",url.absoluteString)
                                let db = Firestore.firestore()
                                let userData: [String:String] = [
                                    "id":authResult.user.uid,
                                    "name":name,
                                    "email":email,
                                    "imageUrl":url.absoluteString
                                ]
                                db.collection("users").document(authResult.user.uid).setData(userData) { error in
                                    if let error = error {
                                        print("Registration Database error",error.localizedDescription)
                                    }else {
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
                }
            }
    }
    
}
}
extension RegisterPageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @objc func selectImage() {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "choose Profile Picture", message: "where do you want to pick your image from?", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { Action in
            self.getImage(from: .camera)
        }
        let galaryAction = UIAlertAction(title: "photo Album", style: .default) { Action in
            self.getImage(from: .photoLibrary)
        }
        let dismissAction = UIAlertAction(title: "Cancle", style: .destructive) { Action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cameraAction)
        alert.addAction(galaryAction)
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    func getImage( from sourceType: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return}
        userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}



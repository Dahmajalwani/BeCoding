//
//  AddInformationViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import UIKit
import Firebase
class AddInformationViewController: UIViewController {
    var selectedCourse:Course?
    var selectedCourseImage:UIImage?
    
    
    @IBOutlet weak var viewHidderr: UIView!
    {
        didSet{
            viewHidderr.layer.borderColor = UIColor.tertiarySystemBackground.cgColor
            viewHidderr.layer.borderWidth = 0
            viewHidderr.layer.cornerRadius = 20
            viewHidderr.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            viewHidderr.layer.masksToBounds = true
            viewHidderr.isUserInteractionEnabled = true
        }
    }
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    {
        didSet {
            titleLabel.text = "title".localized
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel!
    {
        didSet {
            descriptionLabel.text = "description".localized
        }
    }
    @IBOutlet weak var languageLabel: UILabel!
    {
        didSet {
            languageLabel.text = "language".localized
        }
    }
    @IBOutlet weak var instructionLabel: UILabel!
    {
        didSet {
            instructionLabel.text = "instruction".localized
        }
    }
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    {
        didSet {
          
                    userImageView.layer.borderColor = UIColor.systemGray2.cgColor
            userImageView.layer.borderWidth = 1.0
//                    userImageView.layer.cornerRadius = userImageView.bounds.height / 2
                    userImageView.layer.masksToBounds = true
                    userImageView.isUserInteractionEnabled = true
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
                    userImageView.addGestureRecognizer(tabGesture)
            
            userImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
            userImageView.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet weak var userTitleTextField: UITextField!
    @IBOutlet weak var userDescriptionTextField: UITextField!
    @IBOutlet weak var userLangugesTextField: UITextField!
    @IBOutlet weak var userinstructionTextField: UITextField!
  
    
    
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "backButton".localized, style: .plain, target: nil, action: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
        
        if let selectedCourse = selectedCourse,
        let selectedCourseImage = selectedCourseImage{
            userTitleTextField.text = selectedCourse.title
            userDescriptionTextField.text = selectedCourse.description
            userLangugesTextField.text = selectedCourse.language
            userinstructionTextField.text = selectedCourse.instruction
            userImageView.image = selectedCourseImage
            addButton.setTitle("Update Post", for: .normal)
            let deleteBarButton = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(handleDelete))
            self.navigationItem.rightBarButtonItem = deleteBarButton
        }else {
            addButton.setTitle("Add Post", for: .normal)
            self.navigationItem.rightBarButtonItem = nil
            
        }
        // Do any additional setup after loading the view.
    }
    @objc func handleDelete (_ sender: UIBarButtonItem) {
        let ref = Firestore.firestore().collection("posts")
        if let selectedCourse = selectedCourse {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            ref.document(selectedCourse  .id).delete { error in
                if let error = error {
                    print("Error in db delete",error)
                }else {
                    // Create a reference to the file to delete
                    let storageRef = Storage.storage().reference(withPath: "posts/\(selectedCourse.user.id)/\(selectedCourse.id)")
                    // Delete the file
                    storageRef.delete { error in
                        if let error = error {
                            print("Error in storage delete",error)
                        } else {
                            self.activityIndicator.stopAnimating()
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                    
                }
            }
        }
    }
    @IBAction func addButtonTouch(_ sender: Any) {
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let title = userTitleTextField.text,
           let description = userDescriptionTextField.text,
         // let id = userDescriptionTextField.text,
          // let name = userDescriptionTextField.text,
           let instruction = userinstructionTextField.text,
           let language = userLangugesTextField.text,
           let currentUser = Auth.auth().currentUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
//            ref.addDocument(data:)
            var postId = ""
            if let selectedCourse = selectedCourse {
                postId = selectedCourse.user.id
            }else {
                postId = "\(Firebase.UUID())"
            }
            let storageRef = Storage.storage().reference(withPath: "posts/\(currentUser.uid)/\(postId)")
            let updloadMeta = StorageMetadata.init()
            updloadMeta.contentType = "image/jpeg"
            storageRef.putData(imageData, metadata: updloadMeta) { storageMeta, error in
                if let error = error {
                    print("Upload error",error.localizedDescription)
                }
                storageRef.downloadURL { url, error in
                    var postData = [String:Any]()
                    if let url = url {
                        let db = Firestore.firestore()
                        let ref = db.collection("posts")
                        if let selectedCourse = self.selectedCourse {
                            postData = [
                            "userId":selectedCourse.user.id,
//                                "userId":id,
                                "title":title,
                                //"name":name,
                                "description":description,
                                "imageUrl":url.absoluteString,
                                "instruction": instruction,
                                "language": language,
                                "createdAt":selectedCourse.createdAt ?? FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
                            print("******")
                        }else {
                            postData = [
                                "userId":currentUser.uid,
                                "title":title,
                              //  "name":name,
                                "description":description,
                                "imageUrl":url.absoluteString,
                                "instruction": instruction,
                                "language": language,
                                "createdAt":FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
                            print("((((((")
                        }
                        ref.document(postId).setData(postData) { error in
                            if let error = error {
                                print("FireStore Error",error.localizedDescription)
                            }
                            Activity.removeIndicator(parentView: self.view, childView: self.activityIndicator)
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
        
    }
}

extension AddInformationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage() {
        self.showAlert()
    }
    private func showAlert() {
        
        let alert = UIAlertController(title: "Choose Profile Picture", message: "From where you want to pick this image?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
       userImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}


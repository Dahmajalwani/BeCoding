//
//  AddInformationViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 25/05/1443 AH.
//

import UIKit
import Firebase
class AddInformationViewController: UIViewController {
    var selectedUser:User?
    var selectedUserImage:UIImage?
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!{
        didSet {
            userImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
            userImageView.addGestureRecognizer(tapGesture)
        }
    }
    @IBOutlet weak var userTitleTextField: UITextField!
    @IBOutlet weak var userDescriptionTextField: UITextField!
    @IBOutlet weak var userLangugesTextField: UITextField!
    @IBOutlet weak var userinstructionTextField: UITextField!
    @IBOutlet weak var userDataAddTextField: UITextField!
    
    
    let activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let selectedUser = selectedUser,
        let selectedUserImage = selectedUserImage{
            userTitleTextField.text = selectedUser.title
            userDescriptionTextField.text = selectedUser.description
            userImageView.image = selectedUserImage
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
        if let selectedUser = selectedUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
            ref.document(selectedUser.id).delete { error in
                if let error = error {
                    print("Error in db delete",error)
                }else {
                    // Create a reference to the file to delete
                    let storageRef = Storage.storage().reference(withPath: "posts/\(selectedUser.id)")
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
    @IBAction func handleActionTouch(_ sender: Any) {
        if let image = userImageView.image,
           let imageData = image.jpegData(compressionQuality: 0.75),
           let title = userTitleTextField.text,
           let description = userDescriptionTextField.text,
           let currentUser = Auth.auth().currentUser {
            Activity.showIndicator(parentView: self.view, childView: activityIndicator)
//            ref.addDocument(data:)
            var postId = ""
            if let selectedUser = selectedUser {
                postId = selectedUser.id
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
                        if let selectedUser = self.selectedUser {
                            postData = [
//                                "userId":selectedUser.user.id,
                                "title":title,
                                "description":description,
                                "imageUrl":url.absoluteString,
                                "createdAt":selectedUser.createdAt ?? FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
                        }else {
                            postData = [
                                "userId":currentUser.uid,
                                "title":title,
                                "description":description,
                                "imageUrl":url.absoluteString,
                                "createdAt":FieldValue.serverTimestamp(),
                                "updatedAt": FieldValue.serverTimestamp()
                            ]
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


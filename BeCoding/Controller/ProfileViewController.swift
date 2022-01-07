//
//  ProfileViewController.swift
//  BeCoding
//
//  Created by dahma alwani on 04/06/1443 AH.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    var selectedCourse:Course?
    var selectedCourseImage:UIImage?
    var selectedUserImage:UIImage?
    var userCourses = [Course]()
    
    
    @IBOutlet weak var coursePostCollectionView: UICollectionView!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileData()
        getCurrenUserData()
    }
    
    func getCurrenUserData() {
        let refrance = Firestore.firestore()
        if let currentUser = Auth.auth().currentUser {
            let currentUserId = currentUser.uid
            
            refrance.collection("users").document(currentUserId).getDocument {
                userSnapshot,error in
                if let error = error {
                    print("ERROR geting current user snapshot",error.localizedDescription)
                }else {
                    if let userSnapshot = userSnapshot {
                        let userData = userSnapshot.data()
                        if let userData = userData {
                            let currentUserData = User(dict: userData)
                            DispatchQueue.main.async {
                                self.userImage.loadImageUsingCache(with: currentUserData.imageUrl)
                                self.userNameLabel.text = currentUserData.name
                                self.userBioLabel.text = currentUserData.email
                            }
                        }
                    } else {
                        print("User data not found or not the same !!!!")
                    }
                }
            }
        }
    }
    func getProfileData() {
        let ref = Firestore.firestore()
        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
            if let error = error {
                print("DB ERROR Posts",error.localizedDescription)
            }
            if let snapshot = snapshot {
                print("POST CANGES:",snapshot.documentChanges.count)
                snapshot.documentChanges.forEach { diff in
                    let courseData = diff.document.data()
                    switch diff.type {
                        //                        to add info
                    case .added :
                        if let userId = courseData["userId"] as? String {
                            if let currentUserId = Auth.auth().currentUser?.uid {
                                if userId == currentUserId {
                                    print("UserId !!!!!!!!!!!!!!! ",userId)
                                    ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                        if let error = error {
                                            print("ERROR user Data",error.localizedDescription)
                                        }
                                        if let userSnapshot = userSnapshot,
                                           let userData = userSnapshot.data(){
                                            let user = User(dict:userData)
                                            let course = Course(dict:courseData,id:diff.document.documentID,user:user)
//                                            if snapshot.documentChanges.count != 1 {
//                                                self.userCourses.append(course)
//                                                self.coursePostCollectionView.insertItems(at: [IndexPath(item: self.userCourses.count - 1, section: 0)])
//                                            }else {
//                                                self.userCourses.insert(course,at:0)
//                                                self.coursePostCollectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
//                                                print("&&&&&")
//                                                print(course)
//                                            }
                                        }
                                    }
                                }
                            }
                        }
                        print("?????????")
                    case .modified:
                        let postId = diff.document.documentID
                        if let currentPost = self.userCourses.first(where: {$0.id == postId}),
                           let updateIndex = self.userCourses.firstIndex(where: {$0.id == postId}){
                            let newPost = Course(dict: courseData, id: postId, user: currentPost.user)
                            self.userCourses[updateIndex] = newPost
                            self.coursePostCollectionView.deleteItems(at: [IndexPath(item: updateIndex, section: 0)])
                            self.coursePostCollectionView.insertItems(at: [IndexPath(item: updateIndex, section: 0)])
                        }
                    case .removed:
                        let postId = diff.document.documentID
                        if let deleteIndex = self.userCourses.firstIndex(where: {$0.id == postId}){
                            self.userCourses.remove(at: deleteIndex)
                            self.coursePostCollectionView.deleteItems(at: [IndexPath(item: deleteIndex, section: 0)])
                        }
                    }
                }
            }
        }
    }
}
//func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//    guard let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
//    userImage.image = chosenImage
//    dismiss(animated: true, completion: nil)
//}
//func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//    picker.dismiss(animated: true, completion: nil)
//}
//}

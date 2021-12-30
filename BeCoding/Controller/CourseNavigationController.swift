//
//  CourseNavigationController.swift
//  BeCoding
//
//  Created by dahma alwani on 24/05/1443 AH.
//

import UIKit
import Firebase
class CourseViewController: UIViewController{
//                                UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
    
    
//    @IBOutlet weak var courseCollectionView: UICollectionView! {
//        didSet {
////            courseCollectionView.delegate = self
////            courseCollectionView.dataSource = self
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        getUsers()
    }
//    func getUsers() {
//        let ref = Firestore.firestore()
//        ref.collection("posts").order(by: "createdAt",descending: true).addSnapshotListener { snapshot, error in
//            if let error = error {
//                print("",error.localizedDescription)
//            }
//            if let snapshot = snapshot {
//                print("",snapshot.documentChanges.count)
//                snapshot.documentChanges.forEach { diff in
//                    let postData = diff.document.data()
//                    switch diff.type {
//                    case .added :
//
//                        if let userId = postData["userId"] as? String {
//                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
//                                if let error = error {
//                                    print("ERROR",error.localizedDescription)
//
//                                }
////                                if let userSnapshot = userSnapshot,
////                                   let userData = userSnapshot.data(){
//////                                    let user = User(dict:userData)
////                                    let users = User(dict:postData,id:diff.document.documentID,user:user)
////                                    self.courseCollectionView.beginUpdates()
////                                    if snapshot.documentChanges.count != 1 {
////                                        self.users.append(user)
////
////                                        self.courseCollectionView.insertRows(at: [IndexPath(row:self.users.count - 1,section: 0)],with: .automatic)
////                                    }else {
////                                        self.users.insert(user,at:0)
////
////                                        self.courseCollectionView.insertRows(at: [IndexPath(row: 0,section: 0)],with: .automatic)
////                                    }
////
////                                    self.courseCollectionView.endUpdates()
////                                }
//                            }
//                        }
//                    case .modified:
//                        let postId = diff.document.documentID
//                        if let currentPost = self.users.first(where: {$0.id == postId}),
//                           let updateIndex = self.users.firstIndex(where: {$0.id == postId}){
////                            let newUser = User(dict:postData, id: postId, user: currentPost.user)
////                            self.users[updateIndex] = newUser
////
////                                self.courseCollectionView.beginUpdates()
////                                self.courseCollectionView.deleteRows(at: [IndexPath(row: updateIndex,section: 0)], with: .left)
////                                self.courseCollectionView.insertRows(at: [IndexPath(row: updateIndex,section: 0)],with: .left)
////                                self.courseCollectionView.endUpdates()
////
//                        }
//                    case .removed:
//                        let postId = diff.document.documentID
//                        if let deleteIndex = self.users.firstIndex(where: {$0.id == postId}){
//                            self.users.remove(at: deleteIndex)
////
////                                self.courseCollectionView.beginUpdates()
////                                self.courseCollectionView.deleteRows(at: [IndexPath(row: deleteIndex,section: 0)], with: .automatic)
////                                self.courseCollectionView.endUpdates()
//
//                        }
//                    }
//                }
//            }
//        }
//    }
//
    @IBAction func backButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LandingNavigationController") as? UINavigationController {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        } catch  {
            print("ERROR in signout",error.localizedDescription)
        }

    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let identifier = segue.identifier {
//            if identifier == "toPostVC" {
//                let vc = segue.destination as! InformationViewController
//                vc.selectedUser = selectedUser
//                vc.selectedUserImage = selectedUserImage
//            }else {
//                let vc = segue.destination as! AddInformationViewController
//                vc.selectedUser = selectedUser
//                vc.selectedUserImage = selectedUserImage
//            }
//        }
//
//    }
//}

 
}

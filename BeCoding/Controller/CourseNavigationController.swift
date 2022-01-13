//
//  CourseNavigationController.swift
//  BeCoding
//
//  Created by dahma alwani on 24/05/1443 AH.
//

import UIKit
import Firebase
class CourseViewController: UIViewController {
    var course = [Course] ()
    var selectedCourse:Course?
    var selectedCourseImage:UIImage?
    
    @IBOutlet weak var courseCollectionView: UICollectionView! {
        didSet {
            courseCollectionView.delegate = self
            courseCollectionView.dataSource = self
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "backButton".localized, style: .plain, target: nil, action: nil)
        getUsers()
    }
    func getUsers() {
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
                            print("UserId !!!!!!!!!!!!!!! ",userId)
                            ref.collection("users").document(userId).getDocument { userSnapshot, error in
                                if let error = error {
                                    print("ERROR user Data",error.localizedDescription)
                                }
                                if let userSnapshot = userSnapshot,
                                   let userData = userSnapshot.data(){
                                    let user = User(dict:userData)
                                    let course = Course(dict:courseData,id:diff.document.documentID,user:user)
                                    if snapshot.documentChanges.count != 1 {
                                        self.course.append(course)
                                        self.courseCollectionView.insertItems(at: [IndexPath(item: self.course.count - 1, section: 0)])
                                    }else {
                                        self.course.insert(course,at:0)
                                        self.courseCollectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
                                       
                                        print(course)
                                    }
                                }
                            }
                        }
                    case .modified:
                        let postId = diff.document.documentID
                        if let currentPost = self.course.first(where: {$0.id == postId}),
                           let updateIndex = self.course.firstIndex(where: {$0.id == postId}){
                            let newPost = Course(dict: courseData, id: postId, user: currentPost.user)
                            self.course[updateIndex] = newPost
                            self.courseCollectionView.deleteItems(at: [IndexPath(item: updateIndex, section: 0)])
                            self.courseCollectionView.insertItems(at: [IndexPath(item: updateIndex, section: 0)])
                        }
                    case .removed:
                        let postId = diff.document.documentID
                        if let deleteIndex = self.course.firstIndex(where: {$0.id == postId}){
                            self.course.remove(at: deleteIndex)
                            self.courseCollectionView.deleteItems(at: [IndexPath(item: deleteIndex, section: 0)])
                        }
                    }
                }
            }
        }
    }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "toAddVC" {
                let vc = segue.destination as! AddInformationViewController
                vc.selectedCourse = selectedCourse
                vc.selectedCourseImage = selectedCourseImage
            }else if identifier == "toInfoVC" {
                let vc = segue.destination as! InformationViewController
                vc.selectedCourse = selectedCourse
                vc.selectedCourseImage = selectedCourseImage
            }
        }
    }
}
extension CourseViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("*****data print******",course)
        return course.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCollectionViewCell

        print(".", course[indexPath.row])
        cell.layer.borderColor = UIColor.systemGray2.cgColor
        cell.layer.borderWidth = 4.0
        cell.layer.cornerRadius = 20
        
        return cell.configure(with: course[indexPath.row])
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, sizeForItemAT indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.495, height: self.view.frame.width * 0.45)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionView, insetForSrctionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CourseCollectionViewCell
        selectedCourseImage = cell.imageCollectionCell.image
        selectedCourse = course[indexPath.row]
        if let currentUser = Auth.auth().currentUser,currentUser.uid == course[indexPath.row].user.id{
            performSegue(withIdentifier: "toAddVC", sender: self)
        }else {
            performSegue(withIdentifier: "toInfoVC", sender: self)
        }
    }
    
}

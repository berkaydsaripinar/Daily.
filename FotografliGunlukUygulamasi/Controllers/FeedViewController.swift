//
//  FeedViewController.swift
//  FotografliGunlukUygulamasi
//
//  Created by yasin on 26.06.2023.
//

import UIKit
import Firebase
import SDWebImage
class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -ARRAYS
    var emailArray = [String]()
    var commentArray = [String]()
    var imageArray = [String]()
    var dateArray = [String]()
    
    
    //MARK: -TABLEVİEW
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.commentLabel.text = commentArray[indexPath.row]
        cell.usernameLabel.text = emailArray[indexPath.row]
        cell.feedImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        firebaseData()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBAction func refleshButton(_ sender: Any) {
        tableView.reloadData()
    }
    
//MARK: -FİREBASEDATA
    func firebaseData() {
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Post").order(by: "currentdate", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Beklenmedik bir hata oluştu")
            }else{
                if snapshot?.isEmpty != true && snapshot != nil{
                    
                    self.emailArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.commentArray.removeAll(keepingCapacity: false)
                    self.dateArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        if let gorselURL = document.get("pictureurl") as? String{
                            self.imageArray.append(gorselURL)
                        }
                        if let comment = document.get("comment") as? String{
                            self.commentArray.append(comment)
                        }
                        if let dateTime = document.get("currentdate") as? String{
                            self.dateArray.append(dateTime)
                        }
                        if let emailData = document.get("email") as? String {
                            self.emailArray.append(emailData)
                        }
                    } // for döngüsü
                    
                    self.tableView.reloadData()
                }//Snapshot
            }
        }
    } //FirebaseData
}

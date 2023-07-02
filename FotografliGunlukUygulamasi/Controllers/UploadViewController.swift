//
//  UploadViewController.swift
//  FotografliGunlukUygulamasi
//
//  Created by yasin on 26.06.2023.
//

import UIKit
import Firebase
import FirebaseStorage
class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 80.0
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(gorselSec))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    
    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { storageMetaData, error in
                if error != nil {
                    self.errorMessage(title: "Hata", message: error?.localizedDescription ?? "Beklenmedik bir hata oluştu.")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageURL = url?.absoluteString
                            print(imageURL ?? "Beklenmedik hata oluştu")
                            if let imageURL = imageURL {
                                let firestoreDatabase = Firestore.firestore()
                                let firebasePost = ["pictureurl": imageURL, "comment": self.commentTextField.text!,"email": Auth.auth().currentUser!.email ?? "e mail çekilemedi", "date":self.dateTimeTextField.text!, "currentdate":FieldValue.serverTimestamp()] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firebasePost) { error in
                                    if error != nil {
                                        self.errorMessage(title: "Error!", message: error?.localizedDescription ?? "Beklenmedik bir hata oluştu.")
                                    }else{
                                        self.imageView.image = UIImage(named: "Görsel Yükle")
                                        self.commentTextField.text = ""
                                        self.errorMessage(title: "Başarılı", message: "")
                                        self.tabBarController?.selectedIndex = 0
                                        
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    } //uploadButton
    
    
    //MARK: Gorsel Secme Fonksiyonu - Error Message
    @objc func gorselSec(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    func errorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
}

//
//  ViewController.swift
//  FotografliGunlukUygulamasi
//
//  Created by yasin on 26.06.2023.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    //MARK: - LOGİN - SİGN UP
    
    @IBOutlet weak var eMailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    @IBAction func loginButton(_ sender: Any) {
        if eMailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().signIn(withEmail: eMailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Dikkat", messageInput: error?.localizedDescription ?? "Tekrar deneyin, sistemle alakalı bir sorun var.")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else {
            errorMessage(titleInput: "Dikkat", messageInput: "Kullanici adi ya da sifre alani bos")
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        if eMailTextField.text != "" && passwordTextField.text != ""{
            Auth.auth().createUser(withEmail: eMailTextField.text!, password: passwordTextField.text!) { authdataresult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Caution!", messageInput: error?.localizedDescription ?? "Sistemden kaynaklı bir sorun olmuş olabilir, ütfen tekrar deneyin.")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else {
            errorMessage(titleInput: "Caution!", messageInput: "Enter e-mail and password.")
        }
        
    }

    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
  
}


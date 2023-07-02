//
//  SettinngViewController.swift
//  FotografliGunlukUygulamasi
//
//  Created by yasin on 26.06.2023.
//

import UIKit
import Firebase

class SettinngViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func exitButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch{
            print("Hata")
        }
    }
    
    
}

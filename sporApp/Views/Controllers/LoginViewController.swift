//
//  ViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 16.06.2023.
//

import UIKit
import FirebaseAuth




class LoginViewController: UIViewController {
    
    private var loginViewModel = LoginViewModel()
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.loginViewController = self
        
        mailTextField.layer.cornerRadius = 20
        mailTextField.frame = CGRect(x: mailTextField.frame.origin.x, y: mailTextField.frame.origin.y, width: mailTextField.frame.size.width, height: 55)
        sifreTextField.layer.cornerRadius = 20
        sifreTextField.frame = CGRect(x: sifreTextField.frame.origin.x, y: sifreTextField.frame.origin.y, width: sifreTextField.frame.size.width, height: 55)
        
        
    }
    

    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        girisYap()
    }
        
    func girisYap() {
        if let mail = mailTextField.text , let sifre = sifreTextField.text {
            loginViewModel.girisYap(mail, sifre)
        }
      
    }

}


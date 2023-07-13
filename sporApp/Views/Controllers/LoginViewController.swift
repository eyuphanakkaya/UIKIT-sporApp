//
//  ViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 16.06.2023.
//

import UIKit
import Lottie
import FirebaseAuth


class LoginViewController: UIViewController {
    
   private var loginViewModel = LoginViewModel()

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var myLoginView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.loginViewController = self
        if Auth.auth().currentUser != nil {
                    // Kullanıcı giriş yapmışsa başka bir sayfaya yönlendirin veya mevcut sayfada giriş yapılmış olduğunu gösterin
                    // Örnek: Ana sayfaya yönlendirme
            performSegue(withIdentifier: "toKateVC", sender: nil)
        }
        // Do any additional setup after loading the view.
      /*  myLoginView.contentMode = .scaleToFill
        myLoginView.loopMode = .loop
        myLoginView.play()
        myLoginView.backgroundColor = nil
        */
        
    }

    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        girisYap()
    }
    @IBAction func signInGoogleTiklandi(_ sender: Any) {
    }

 
    

    func girisYap() {
        if let mail = mailTextField.text , let sifre = sifreTextField.text {
            loginViewModel.girisYap(mail, sifre)
        }
      
    }

}


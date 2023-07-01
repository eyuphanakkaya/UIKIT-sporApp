//
//  ViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 16.06.2023.
//

import UIKit
import Lottie
import FirebaseAuth


class ViewController: UIViewController {

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var myLoginView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myLoginView.contentMode = .scaleToFill
        myLoginView.loopMode = .loop
        myLoginView.play()
        myLoginView.backgroundColor = nil
        
        
        
    }

    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        girisYap()
    }
    @IBAction func signInGoogleTiklandi(_ sender: Any) {
    }
    @IBAction func signInAppleTiklandi(_ sender: Any) {
        
    }
    

    func uyeOlHata(){
        let uyeOl = UIAlertController(title: "UYARI", message: "Lütfen değilseniz uye olunuz", preferredStyle: .alert)
        let uyeAction = UIAlertAction(title: "Tamam", style: .cancel)
        uyeOl.addAction(uyeAction)
        present(uyeOl, animated: true)
    }
    func girisYap() {
        if let mail = mailTextField.text , let sifre = sifreTextField.text {
            Auth.auth().signIn(withEmail: mail, password: sifre) { (user, error) in
                if error != nil {
                    // Giriş sırasında bir hata oluştu
                    self.uyeOlHata()
                } else {
                    // Giriş başarılı
                    print("Giriş başarılı. Kullanıcı: \(user?.user.uid ?? "")")
                    self.performSegue(withIdentifier: "toKateVC", sender: nil)
                }
            }
        }
      
    }

}


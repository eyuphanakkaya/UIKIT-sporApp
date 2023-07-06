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

    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    @IBOutlet weak var myLoginView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
                    // Kullanıcı giriş yapmışsa başka bir sayfaya yönlendirin veya mevcut sayfada giriş yapılmış olduğunu gösterin
                    // Örnek: Ana sayfaya yönlendirme
            performSegue(withIdentifier: "toKateVC", sender: nil)
        }
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
    

    func girisHata(mesaj:String){
        let uyeOl = UIAlertController(title: "Uyarı", message: mesaj, preferredStyle: .alert)
        let uyeAction = UIAlertAction(title: "Tamam", style: .cancel)
        uyeOl.addAction(uyeAction)
        present(uyeOl, animated: true)
    }

    func girisYap() {
        if let mail = mailTextField.text , let sifre = sifreTextField.text {
            Auth.auth().signIn(withEmail: mail, password: sifre) { (user, error) in
                if error != nil {
                    // Giriş sırasında bir hata oluştu
                    if mail == "" && sifre == "" {
                        self.girisHata(mesaj: "Lütfen boş bırakmayınız.")
                    } else if mail == "" {
                        self.girisHata(mesaj: "Lütfen Mail'i boş bırakmayınız.")
                    } else if sifre == "" {
                        self.girisHata(mesaj: "Lütfen şifreyi boş bırakmayınız.")
                    } else {
                        self.girisHata(mesaj: "Lütfen geçerli değerler giriniz veya kayıtlı değilseniz kayolunuz.")
                    }
                   
                } else {
                    // Giriş başarılı
                    print("Giriş başarılı. Kullanıcı: \(user?.user.uid ?? "")")
                    self.performSegue(withIdentifier: "toKateVC", sender: nil)
                }
            }
        }
      
    }

}


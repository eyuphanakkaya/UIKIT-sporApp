//
//  LoginViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 10.07.2023.
//

import FirebaseAuth
import UIKit

final class LoginViewModel {
    weak var loginViewController: LoginViewController?
    
    func girisYap(_ mail: String,_ sifre: String) {
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
                self.loginViewController?.performSegue(withIdentifier: "toKateVC", sender: nil)
            }
        }
    }
    
    func girisHata(mesaj:String){
        guard let viewController = loginViewController else {
            return
        }
        
        let uyeOl = UIAlertController(title: "Uyarı", message: mesaj, preferredStyle: .alert)
        let uyeAction = UIAlertAction(title: "Tamam", style: .cancel)
        uyeOl.addAction(uyeAction)
        viewController.present(uyeOl, animated: true)
    }
}

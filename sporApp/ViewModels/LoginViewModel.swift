//
//  LoginViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 10.07.2023.
//

import FirebaseAuth
import UIKit

final class LoginViewModel {
    
    var alerts = AlertAction()
    weak var loginViewController: LoginViewController?
    
    func girisYap(_ mail: String,_ sifre: String) {
        Auth.auth().signIn(withEmail: mail, password: sifre) { (user, error) in
            if error != nil {
                // Giriş sırasında bir hata oluştu
                if mail == "" && sifre == "" {
                    self.alerts.girisHata(mesaj: "Lütfen boş bırakmayınız.", viewControllers: self.loginViewController)
                   
                } else if mail == "" {
                    self.alerts.girisHata(mesaj: "Lütfen Mail'i boş bırakmayınız.", viewControllers: self.loginViewController)
                } else if sifre == "" {
                    self.alerts.girisHata(mesaj: "Lütfen şifreyi boş bırakmayınız.", viewControllers: self.loginViewController)
                } else {
                    self.alerts.girisHata(mesaj: "Lütfen geçerli değerler giriniz veya kayıtlı değilseniz kayolunuz.", viewControllers: self.loginViewController)
                }
               
            } else {
                // Giriş başarılı
                print("Giriş başarılı. Kullanıcı: \(user?.user.uid ?? "")")
                self.loginViewController?.performSegue(withIdentifier: "toKateVC", sender: nil)
            }
        }
    }
    

}

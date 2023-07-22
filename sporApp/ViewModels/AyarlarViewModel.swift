//
//  AyarlarVİewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 11.07.2023.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase


protocol AyarlarViewDelegate: AnyObject {
    func didFetchGirisBilgi(_ girisBilgileri: Kullanicilar?)
}
class AyarlarViewModel {
    var durum = true
    var ref: DatabaseReference?
    var ayarlarViewController: AyarlarViewController?
    var alerts = AlertAction()
    
    func getGirisBilgi(completion: @escaping (Kullanicilar?) -> Void) {
           if let currentUser = Auth.auth().currentUser {
               ref = Database.database().reference()
               let userId = currentUser.uid
               ref!.child("Kullanicilar").child(userId).observeSingleEvent(of: .value, with: { snapshot in
                   if let kullaniciBilgileri = snapshot.value as? [String: Any] {
                       let girisBilgileri = Kullanicilar(ad: kullaniciBilgileri["kullanici_ad"] as? String,soyad: kullaniciBilgileri["kullanici_soyisim"] as? String,mail: kullaniciBilgileri["kullanici_mail"] as? String,sifre: kullaniciBilgileri["kullanici_sifre"] as? String)
                       completion(girisBilgileri)
                   } else {
                       completion(nil)
                   }
               })
           } else {
               completion(nil)
           }
       }
    
    func cikisYap(){
        do {
            try Auth.auth().signOut()
            // Kullanıcı başarıyla çıkış yaptıktan sonra yapılması istenen işlemler
            // Örneğin, login ekranına geri dönme
            let loginViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
                       UIApplication.shared.windows.first?.rootViewController = loginViewController
     
            
        } catch let error as NSError {
            // Çıkış işlemi sırasında bir hata oluştu
            print("Çıkış yaparken hata oluştu: \(error.localizedDescription)")
        }
    }
    func darkMode(sender: UISwitch){
        if #available(iOS 13.0, *) {
            let appDelegate = UIApplication.shared.windows.first
            if sender.isOn {
                durum = true
                appDelegate?.overrideUserInterfaceStyle = .light
                return
            } else {
                durum = false
                appDelegate?.overrideUserInterfaceStyle = .dark
                return
            }
            
          
        }
    }
    func kisiGuncelle(kullanici_ad: String, kullanici_soyisim: String, kullanici_sifre: String, kullanici_mail: String) {
        ref = Database.database().reference()
        if let currentUser = Auth.auth().currentUser {
            let userID = currentUser.uid

            // Güncellenmek istenen verinin yolu
            let dataPath = "Kullanicilar/\(userID)"

            let dict: [String: Any] = [
                "kullanici_ad": kullanici_ad,
                "kullanici_soyisim": kullanici_soyisim,
                "kullanici_sifre": kullanici_sifre,
                "kullanici_mail": kullanici_mail
            ]

            if !kullanici_ad.isEmpty && !kullanici_soyisim.isEmpty && !kullanici_sifre.isEmpty && !kullanici_mail.isEmpty && kullanici_sifre.count >= 7 {
                ref!.child(dataPath).updateChildValues(dict) { (error, _) in
                    if let error = error {
                        print("Veri güncellenirken hata oluştu: \(error)")
                    } else {
                        self.alerts.girisHata(title: "Bilgi", mesaj: "Kullanıcı Güncellendi.", viewControllers: self.ayarlarViewController)
                        
                    }
                }
                currentUser.updateEmail(to: kullanici_mail)
                currentUser.updatePassword(to: kullanici_sifre)
            } else if kullanici_sifre.count < 7  {
                alerts.girisHata(title: "Hata", mesaj: "Lütfen şifreyi yedi karakterden az girmeyin", viewControllers: ayarlarViewController)
            } else {
                alerts.girisHata(title: "Hata", mesaj: "Lütfen değerleri boş bırakmayınız", viewControllers: ayarlarViewController)
            }

        }
    }
    
}

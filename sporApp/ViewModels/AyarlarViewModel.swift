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

            // Veriyi güncelleme işlemi
            ref!.child(dataPath).updateChildValues(dict) { (error, _) in
                if let error = error {
                    print("Veri güncellenirken hata oluştu: \(error)")
                } else {
                    self.alerts.girisHata(mesaj: "Kullanıcı Güncellendi.", viewControllers: self.ayarlarViewController)
                    
                }
            }
            currentUser.updateEmail(to: kullanici_mail)
            currentUser.updatePassword(to: kullanici_sifre)
        }
    }
    
}

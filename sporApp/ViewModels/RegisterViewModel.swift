//
//  RegisterViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 10.07.2023.
//

import Foundation
import Firebase


class RegisterViewModel {
    var registerViewController: RegisterViewController?
    var ref:DatabaseReference?
    var alerts = AlertAction()
   
    func kisiKaydet(kullanici_ad: String, kullanici_soyisim: String, kullanici_sifre: String, kullanici_mail: String) {
        if !kullanici_ad.isEmpty && !kullanici_soyisim.isEmpty && !kullanici_sifre.isEmpty && !kullanici_mail.isEmpty &&  kullanici_sifre.count>7{
            
            authKaydet(kullanici_mail: kullanici_mail, kullanici_sifre: kullanici_sifre)
            
            ref = Database.database().reference()
            let dict: [String: Any] = ["kullanici_ad": kullanici_ad, "kullanici_soyisim": kullanici_soyisim, "kullanici_sifre": kullanici_sifre, "kullanici_mail": kullanici_mail]
            let newRef = ref?.child("Kullanicilar").childByAutoId()
            newRef?.setValue(dict) { (error, ref) in
                if let error = error {
                    self.alerts.girisHata(title: "Hata", mesaj: "Kayıt oluşturulamadı.", viewControllers: self.registerViewController)
                } else {
                    self.alerts.girisHata(title: "Bilgi", mesaj: "Kayıt oluşturuldu.", viewControllers: self.registerViewController)
                    
                }
            }
        } else if !kullanici_sifre.isEmpty && kullanici_sifre.count<7 {
            alerts.girisHata(title: "Hata", mesaj: "Lütfen şifreyi yedi karakterden az girmeyin", viewControllers: registerViewController)
        } else {
            alerts.girisHata(title: "Hata", mesaj: "Lütfen boş bırakmayınız", viewControllers: registerViewController)
        }
    }
    func authKaydet(kullanici_mail:String,kullanici_sifre:String){
        Auth.auth().createUser(withEmail: kullanici_mail, password: kullanici_sifre) {
            authResult, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print("Kayıt başarıyla oluşturuldu.")
            }
        }
        
    }
}

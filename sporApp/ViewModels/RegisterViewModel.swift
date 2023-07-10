//
//  RegisterViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 10.07.2023.
//

import Foundation
import Firebase

final class RegisterViewModel {
    weak var registerViewController: RegisterViewController?
    var ref:DatabaseReference?
   
    func kisiKaydet(kullanici_ad: String, kullanici_soyisim: String, kullanici_sifre: String, kullanici_mail: String) {
        ref = Database.database().reference()
        let dict: [String: Any] = ["kullanici_ad": kullanici_ad, "kullanici_soyisim": kullanici_soyisim, "kullanici_sifre": kullanici_sifre, "kullanici_mail": kullanici_mail]
        let newRef = ref?.child("Kullanicilar").childByAutoId()
        newRef?.setValue(dict) { (error, ref) in
            if let error = error {
                print("Kayıt oluşturma hatası: \(error.localizedDescription)")
            } else {
                
                self.kayitOlusturuldu()
            }
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
    
    func kayitOlusturuldu(){
        guard let viewController = registerViewController else {
            return
        }
        
        let kayit = UIAlertController(title: "KAYIT", message: "Kayıt oluşturuldu.", preferredStyle: .alert)
        let kayitAction = UIAlertAction(title: "Tamam", style: .cancel) { action in
            viewController.navigationController?.popViewController(animated: true)
        }
        
        kayit.addAction(kayitAction)
        viewController.present(kayit, animated: true)
    }
}

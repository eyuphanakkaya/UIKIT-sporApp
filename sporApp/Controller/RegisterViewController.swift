//
//  RegisterViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 16.06.2023.
//

import UIKit
import Lottie
import Firebase

class RegisterViewController: UIViewController {
    var ref:DatabaseReference?
    @IBOutlet weak var kullaniciMailTextField: UITextField!
    @IBOutlet weak var kullaniciSifreTextField: UITextField!
    @IBOutlet weak var kullaniciSoyadTextField: UITextField!
    @IBOutlet weak var kullaniciAdTextField: UITextField!
    @IBOutlet weak var registerView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = false
        registerView.contentMode = .scaleToFill
        registerView.loopMode = .loop
        registerView.play()
    }
    @IBAction func kayitOlusturTiklandi(_ sender: Any) {
        if let kullanici_ad = kullaniciAdTextField.text , let kullanici_soyisim = kullaniciSoyadTextField.text,let kullanici_sifre =
            kullaniciSifreTextField.text,let kullanici_mail = kullaniciMailTextField.text {
            
            kisiKaydet(kullanici_ad: kullanici_ad, kullanici_soyisim: kullanici_soyisim, kullanici_sifre: kullanici_sifre, kullanici_mail: kullanici_mail)
            authKaydet(kullanici_mail: kullanici_mail, kullanici_sifre: kullanici_sifre)
        }
    }
    func authKaydet(kullanici_mail:String,kullanici_sifre:String){
        Auth.auth().createUser(withEmail: kullanici_mail, password: kullanici_sifre) {
            authResult, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                self.kayitOlusturuldu()
            }
        }
        
    }
    
    @IBAction func geridonTiklandi(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func       kisiKaydet(kullanici_ad:String,kullanici_soyisim:String,kullanici_sifre:String,kullanici_mail:String){
        let dict:[String:Any] = ["kullanici_ad":kullanici_ad,"kullanici_soyisim":kullanici_soyisim,"kullanici_sifre":kullanici_sifre,"kullanici_mail":kullanici_mail]
        let newRef = ref?.child("Kullanicilar").childByAutoId()
        newRef?.setValue(dict)
    }
    
    func kayitOlusturuldu(){
        let kayit = UIAlertController(title: "KAYIT", message: "Kayıt oluşturuldu.", preferredStyle: .alert)
        let kayitAction = UIAlertAction(title: "Tamam", style: .cancel) { action in
            self.navigationController?.popViewController(animated: true)
        }
        
        kayit.addAction(kayitAction)
        present(kayit, animated: true)
    }


}

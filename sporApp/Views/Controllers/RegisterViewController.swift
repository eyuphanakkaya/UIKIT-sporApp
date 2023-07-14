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
    
    var registerViewModel = RegisterViewModel()
    
    @IBOutlet weak var kullaniciMailTextField: UITextField!
    @IBOutlet weak var kullaniciSifreTextField: UITextField!
    @IBOutlet weak var kullaniciSoyadTextField: UITextField!
    @IBOutlet weak var kullaniciAdTextField: UITextField!
    @IBOutlet weak var registerView: LottieAnimationView!
    
    
    override func viewDidLoad() {
        
        registerViewModel.registerViewController = self
        
        super.viewDidLoad()
        
        navigationItem.titleView?.tintColor = .white
       /* registerView.contentMode = .scaleToFill
        registerView.loopMode = .loop
        registerView.play()*/
    }
    
    @IBAction func geriTiklandi(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func kayitOlusturTiklandi(_ sender: Any) {
        if let kullanici_ad = kullaniciAdTextField.text , let kullanici_soyisim = kullaniciSoyadTextField.text,let kullanici_sifre =
            kullaniciSifreTextField.text,let kullanici_mail = kullaniciMailTextField.text {
            
            registerViewModel.kisiKaydet(kullanici_ad: kullanici_ad, kullanici_soyisim: kullanici_soyisim, kullanici_sifre: kullanici_sifre, kullanici_mail: kullanici_mail)
        }
    }





}

//
//  AyarlarViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit
import Firebase

class AyarlarViewController: UIViewController {
    
    var ref: DatabaseReference?
    var ayarlarViewModel = AyarlarViewModel()
    @IBOutlet weak var viewComp: UIView!
    
  
    @IBOutlet weak var modeSwitch: UISwitch!
    
    @IBOutlet weak var kullaniciSifreTextField: UITextField!
    @IBOutlet weak var kullaniciMailTextField: UITextField!
    @IBOutlet weak var kullaniciSoyadTextField: UITextField!
    @IBOutlet weak var kullaniciAdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ayarlarViewModel.ayarlarViewController = self
        viewComp.layer.cornerRadius = 20
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        ayarlarViewModel.getGirisBilgi { [weak self] ayarlar in
            // Giriş bilgileri geldiğinde veya nil ise ViewModelDelegate aracılığıyla View Controller'a iletilir
            self?.didFetchGirisBilgi(ayarlar)
        }
    }
    
    @IBAction func onClickedSwitch(_ sender: UISwitch) {
        ayarlarViewModel.darkMode(sender: sender)
        
    }

    

    
    @IBAction func guncelleTiklandi(_ sender: Any) {
        if let kullanici_ad = kullaniciAdTextField.text , let kullanici_soyisim = kullaniciSoyadTextField.text,let kullanici_sifre =
            kullaniciSifreTextField.text,let kullanici_mail = kullaniciMailTextField.text {
            ayarlarViewModel.kisiGuncelle(kullanici_ad: kullanici_ad, kullanici_soyisim: kullanici_soyisim, kullanici_sifre: kullanici_sifre, kullanici_mail: kullanici_mail)
        }
    }
    @IBAction func cikisYapTiklandi(_ sender: Any) {
        ayarlarViewModel.cikisYap()
    }
}

extension AyarlarViewController: AyarlarViewDelegate {
    func didFetchGirisBilgi(_ girisBilgileri: Kullanicilar?) {
        kullaniciAdTextField.text = girisBilgileri?.ad
        kullaniciSoyadTextField.text = girisBilgileri?.soyad
        kullaniciMailTextField.text = girisBilgileri?.mail
        kullaniciSifreTextField.text = girisBilgileri?.sifre
    }
}

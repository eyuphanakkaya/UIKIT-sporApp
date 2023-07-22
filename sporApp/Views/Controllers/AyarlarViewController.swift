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
    
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var viewComp: UIView!
    @IBOutlet weak var modeSwitch: UISwitch!
    @IBOutlet weak var kullaniciSifreTextField: UITextField!
    @IBOutlet weak var kullaniciMailTextField: UITextField!
    @IBOutlet weak var kullaniciSoyadTextField: UITextField!
    @IBOutlet weak var kullaniciAdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kullaniciAdTextField.delegate = self
        kullaniciSifreTextField.delegate = self
        kullaniciSoyadTextField.delegate = self
        kullaniciMailTextField.delegate = self
        
        
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
        modeSwitch = sender

        ayarlarViewModel.darkMode(sender: sender)
        if ayarlarViewModel.durum {
            modeLabel.text = "Light"
        } else {
            modeLabel.text = "Dark"
        }
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
extension AyarlarViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == kullaniciAdTextField{
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updatedText.count <= 20
        } else if textField == kullaniciSoyadTextField {
            let currentText = textField.text ?? ""
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updateText.count <= 13
        } else if textField == kullaniciMailTextField {
            let currentText = textField.text ?? ""
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updateText.count <= 25
        } else {
            let currentText = textField.text ?? ""
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updateText.count <= 15
        }
        return true
    }
}

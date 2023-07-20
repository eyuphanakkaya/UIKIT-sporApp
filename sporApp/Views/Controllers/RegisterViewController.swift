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
        
        
        kullaniciAdTextField.delegate = self
        kullaniciSifreTextField.delegate = self
        kullaniciSoyadTextField.delegate = self
        kullaniciMailTextField.delegate = self
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
extension RegisterViewController: UITextFieldDelegate {
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

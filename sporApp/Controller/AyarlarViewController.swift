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
    @IBOutlet weak var kullaniciSifreTextField: UITextField!
    @IBOutlet weak var kullaniciMailTextField: UITextField!
    @IBOutlet weak var kullaniciSoyadTextField: UITextField!
    @IBOutlet weak var kullaniciAdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func guncelleTiklandi(_ sender: Any) {
        if let kullanici_ad = kullaniciAdTextField.text , let kullanici_soyisim = kullaniciSoyadTextField.text,let kullanici_sifre =
            kullaniciSifreTextField.text,let kullanici_mail = kullaniciMailTextField.text {
            
        }
    }
    @IBAction func cikisYapTiklandi(_ sender: Any) {
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
    func kisiGuncelle(){
        
    }
    
}

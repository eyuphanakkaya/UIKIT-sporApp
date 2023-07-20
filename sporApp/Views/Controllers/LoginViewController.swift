//
//  ViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 16.06.2023.
//

import UIKit
import FirebaseAuth




class LoginViewController: UIViewController {
    
    private var loginViewModel = LoginViewModel()
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var sifreTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginViewModel.loginViewController = self
        
        mailTextField.delegate = self
        sifreTextField.delegate = self
        
        mailTextField.layer.cornerRadius = 20
        mailTextField.frame = CGRect(x: mailTextField.frame.origin.x, y: mailTextField.frame.origin.y, width: mailTextField.frame.size.width, height: 55)
        sifreTextField.layer.cornerRadius = 20
        sifreTextField.frame = CGRect(x: sifreTextField.frame.origin.x, y: sifreTextField.frame.origin.y, width: sifreTextField.frame.size.width, height: 55)
        
        
    }
    

    
    @IBAction func girisYapTiklandi(_ sender: Any) {
        girisYap()
    }
        
    func girisYap() {
        if let mail = mailTextField.text , let sifre = sifreTextField.text {
            loginViewModel.girisYap(mail, sifre)
        }
      
    }

}
extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mailTextField{
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        } else if textField == sifreTextField {
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updatedText.count <= 15
        }
        return true
    }
}



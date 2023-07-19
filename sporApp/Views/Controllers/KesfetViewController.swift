//
//  KesfetViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 15.07.2023.
//

import UIKit
import Lottie


class KesfetViewController: UIViewController {
    
    var alerts = AlertAction()
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var kiloTextField: UITextField!
    @IBOutlet weak var yasTextField: UITextField!
    @IBOutlet weak var boyTextField: UITextField!
    @IBOutlet weak var genderView: LottieAnimationView!
    var kesfetViewModel =  KesfetViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        genderView.play()
        
        kesfetViewModel.kesfetViewController = self
        kiloTextField.delegate = self
        yasTextField.delegate = self
        boyTextField.delegate = self

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAltBaslik", let hucreNo = sender as? Int {
            let destinationVC = segue.destination as? AltBaslikViewController
                destinationVC?.gelen =  hucreNo
        }
        
    }

    
    @IBAction func segmentedClicked(_ sender: Any) {
        if genderSegmented.selectedSegmentIndex == 0 {
            genderView.animation = LottieAnimation.named("women")
            genderView.play()
            
            
        } else {
            genderView.animation = .named("man")
            genderView.play()
        }
    }
    func bosKontrol() {
        if let kiloString = kiloTextField.text ,let yasString = yasTextField.text, let boyString = boyTextField.text {
            if kiloString == "" || yasString == "" || boyString == "" {
                alerts.girisHata(mesaj: "Lütfen boş bırakmayınız.", viewControllers: self)
            }
        }
    }

    @IBAction func buttonClicked(_ sender: Any) {
       bosKontrol()
        if let kilo = Int(kiloTextField.text ?? "")
            ,let yas = Int(yasTextField.text ?? "")
            ,let boy = Int(boyTextField.text ?? "") {
            if genderSegmented.selectedSegmentIndex == 0 {
                kesfetViewModel.kadinOneri(yas: yas, kilo: kilo, boy: boy)

            } else {
                kesfetViewModel.erkekOneri(yas: yas, kilo: kilo, boy: boy)
            }
        }
        
    }
    

}
extension KesfetViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacterSet = CharacterSet(charactersIn: "0123456789")
                let inputCharacterSet = CharacterSet(charactersIn: string)
        if textField == kiloTextField{
            let currentText = textField.text ?? ""
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updatedText.count <= 3 && allowedCharacterSet.isSuperset(of: inputCharacterSet)
        } else if textField == yasTextField {
            let currentText = textField.text ?? ""
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updateText.count <= 2 &&  allowedCharacterSet.isSuperset(of: inputCharacterSet)
        } else {
            let currentText = textField.text ?? ""
            let updateText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return updateText.count <= 3 &&  allowedCharacterSet.isSuperset(of: inputCharacterSet)
        }
        return true
    }
}

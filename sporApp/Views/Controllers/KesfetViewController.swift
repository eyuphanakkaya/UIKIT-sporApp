//
//  KesfetViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 15.07.2023.
//

import UIKit
import Lottie


class KesfetViewController: UIViewController {

    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var kiloTextField: UITextField!
    @IBOutlet weak var yasTextField: UITextField!
    @IBOutlet weak var boyTextField: UITextField!
    @IBOutlet weak var genderView: LottieAnimationView!
    
    
    var alerts = AlertAction()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        genderView.contentMode = .scaleAspectFit
        genderView.loopMode = .loop
        genderView.play()

    }
    
    @IBAction func segmentedClicked(_ sender: Any) {
        if genderSegmented.selectedSegmentIndex == 0 {
            print("Kadın")
            genderView.animation = .named("women")
            genderView.play()
            
            
        } else {
            print("Erkek")
            genderView.animation = .named("man")
            genderView.play()
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        if let kilo = Int(kiloTextField.text ?? "")
            ,let yas = Int(yasTextField.text ?? "")
            ,let boy = Float(boyTextField.text ?? "") {
            if genderSegmented.selectedSegmentIndex == 0 {
                if yas <= 18 && kilo <= 50 && boy <= 1.65 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Yoga için uygundur.", viewControllers: KesfetViewController())
                    print("Sayfa geçişi: Yoga")
                    return
                } else if  yas > 18 && kilo <= 60 && boy <= 1.70 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Fitness için uygundur.", viewControllers: KesfetViewController())
                    print("Sayfa geçişi: Fitness")
                    return
                } else if yas <= 18   && kilo <= 55 && boy <= 1.75 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Pilates için uygundur.", viewControllers: KesfetViewController())
                    print("Sayfa geçişi: Pilates")
                    return
                } else if yas <= 18 && kilo <= 65 && boy <= 1.80 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Kick Boks için uygundur.", viewControllers: KesfetViewController())
                    print("Sayfa geçişi: Kick Boks")
                    return
                } else if yas <= 18 && kilo <= 70 && boy <= 1.85 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Bale için uygundur.", viewControllers: KesfetViewController())
                    print("Sayfa geçişi: Bale")
                    return
                } else {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınıza uygun bir spor bulunamadı.", viewControllers: KesfetViewController())
                    print("Sayfa geçişi: Spor bulunamadı")
                    return
                }

            }
        }
        
    }
    

}

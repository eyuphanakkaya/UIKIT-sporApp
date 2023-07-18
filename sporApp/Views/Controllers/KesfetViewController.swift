//
//  KesfetViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 15.07.2023.
//

import UIKit
import Lottie


class KesfetViewController: UIViewController {

    var kate = KategoriViewController()
    var kesfetViewController: KesfetViewController?
    @IBOutlet weak var genderSegmented: UISegmentedControl!
    @IBOutlet weak var kiloTextField: UITextField!
    @IBOutlet weak var yasTextField: UITextField!
    @IBOutlet weak var boyTextField: UITextField!
    @IBOutlet weak var genderView: LottieAnimationView!
    var hucreNo: Int?
    
    
    var alerts = AlertAction()
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueIdentifier" {
            if let destinationVC = segue.destination as? AltBaslikViewController, let hucreNo = sender as? Int {
                destinationVC.kategori = kate.kategoriList[hucreNo - 1]
            }
        }
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
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Yoga için uygundur.", viewControllers: self)
                    hucreNo = 2
                    self.performSegue(withIdentifier: "AltBaslik", sender: hucreNo)
                    return
                } else if  yas > 18 && kilo <= 60 && boy <= 1.70 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Fitness için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Fitness")
                    return
                } else if yas <= 18   && kilo <= 55 && boy <= 1.75 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Pilates için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Pilates")
                    return
                } else if yas <= 18 && kilo <= 65 && boy <= 1.80 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Kick Boks için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Kick Boks")
                    return
                } else if yas <= 18 && kilo <= 70 && boy <= 1.85 {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınız Bale için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Bale")
                    return
                } else {
                    alerts.girisHata(mesaj: "Boy Kilo ve Yaşınıza uygun bir spor bulunamadı.", viewControllers: self)
                    print("Sayfa geçişi: Spor bulunamadı")
                    return
                }

            } else {
                if yas <= 18 && kilo <= 60 && boy <= 175 {
                    alerts.girisHata(mesaj: "Yaş, Boy ve Kilonuza uygun Yoga için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Yoga")
                    return
                } else if yas > 18 && kilo <= 80 && boy <= 180 {
                    alerts.girisHata(mesaj: "Yaş, Boy ve Kilonuza uygun Fitness için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Fitness")
                    return
                } else if yas <= 18 && kilo <= 70 && boy <= 185 {
                    alerts.girisHata(mesaj: "Yaş, Boy ve Kilonuza uygun Pilates için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Pilates")
                    return
                } else if yas <= 18 && kilo <= 80 && boy <= 190 {
                    alerts.girisHata(mesaj: "Yaş, Boy ve Kilonuza uygun Kick Boks için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Kick Boks")
                    return
                } else if yas <= 18 && kilo <= 90 && boy <= 195 {
                    alerts.girisHata(mesaj: "Yaş, Boy ve Kilonuza uygun Bale için uygundur.", viewControllers: self)
                    print("Sayfa geçişi: Bale")
                    return
                } else {
                    alerts.girisHata(mesaj: "Yaş, Boy ve Kilonuza uygun bir spor bulunamadı.", viewControllers: self)
                    print("Sayfa geçişi: Spor bulunamadı")
                    return
                }
            }
        }
        
    }
    

}

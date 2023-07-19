//
//  KesfetViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 19.07.2023.
//

import Foundation
import Lottie
import UIKit



class KesfetViewModel {
    var alert = YonlendirmeAlert()
    var alerts = AlertAction()
    var hucreNo: Int?
    var kesfetViewController: KesfetViewController?

    func kadinOneri(yas: Int,kilo: Int,boy: Int){
        if yas <= 18 && kilo <= 50 && boy <= 165 {
            hucreNo = 4
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Yoga için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else if  yas > 18 && kilo <= 60 && boy <= 170 {
            hucreNo = 1
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Fitness için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            print("Sayfa geçişi: Fitness")
            return
        } else if yas <= 18   && kilo <= 55 && boy <= 175 {
            hucreNo = 2
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Pilates için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else if yas <= 18 && kilo <= 65 && boy <= 180 {
            hucreNo = 3
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Kick Boks için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else if yas <= 18 && kilo <= 70 && boy <= 185 {
            hucreNo = 5
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Bale için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else {
            alerts.girisHata(mesaj: "Boy Kilo ve Yaşınıza uygun bir spor bulunamadı.", viewControllers: kesfetViewController)
            return
        }
    }
    func erkekOneri(yas: Int,kilo: Int,boy: Int){
        if yas <= 18 && kilo <= 60 && boy <= 175 {
            hucreNo = 4
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Yoga için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else if yas > 18 && kilo <= 150 && boy <= 180 {
            hucreNo = 1
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Fitness için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else if yas <= 18 && kilo <= 70 && boy <= 185 {
            hucreNo = 2
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Pilates için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else if yas <= 18 && kilo <= 100 && boy <= 190 {
            hucreNo = 3
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Kick Boks için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else if yas <= 18 && kilo <= 90 && boy <= 195 {
            hucreNo = 5
            alert.yonlendir(mesaj: "Boy Kilo ve Yaşınız Bale için uygundur.", viewControllers: kesfetViewController, hucreNo: hucreNo ?? 0, identifier: "goToAltBaslik")
            return
        } else {
            alerts.girisHata(mesaj: "Boy Kilo ve Yaşınıza uygun bir spor bulunamadı.", viewControllers: kesfetViewController)
            return
        }
    }

}


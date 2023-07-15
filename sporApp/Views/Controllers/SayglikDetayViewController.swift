//
//  SayglikDetayViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 15.07.2023.
//

import UIKit
import CoreMotion

class SayglikDetayViewController: UIViewController {
    let pedometer = CMPedometer()

    override func viewDidLoad() {
        super.viewDidLoad()
        startTracking()
    }

    func startTracking() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("Adım sayısı izleme özelliği kullanılamıyor.")
            return
        }

        pedometer.startUpdates(from: Date()) { data, error in
            guard let data = data, error == nil else {
                print("Adım sayısı verisi alınamadı: \(error?.localizedDescription ?? "")")
                return
            }

            if let distance = data.distance?.doubleValue {
                print("Mesafe: \(distance) metre")
            }

            if let averagePace = data.averageActivePace?.doubleValue {
                print("Ortalama Hız: \(averagePace) metre/saniye")
            }

            if let calories = data.averageActivePace?.doubleValue {
                print("Yakılan Kalori: \(calories) kalori")
            }


        }
    }

    func stopTracking() {
        pedometer.stopUpdates()
    }
}

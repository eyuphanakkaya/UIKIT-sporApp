//
//  HealthViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 13.07.2023.
//

import UIKit
import HealthKit

class HealthViewController: UIViewController {
    let healthStore = HKHealthStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeHealthKit()
        readHeartRate()
        readActiveEnergy()
        readWalkingRunningDistance()
        
    }
   
    func authorizeHealthKit() {
        let typesToShare: Set<HKSampleType> = [] // Paylaşmak istediğiniz veri tiplerini belirtin
        let typesToRead: Set<HKObjectType> = [HKObjectType.quantityType(forIdentifier: .heartRate)!] // Okumak istediğiniz veri tiplerini belirtin
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if let error = error {
                // Yetkilendirme hatası
                print("Yetkilendirme hatası: \(error.localizedDescription)")
            } else {
                // Yetkilendirme başarılı
                if success {
                    print("Yetkilendirme başarılı!")
                } else {
                    print("Yetkilendirme reddedildi.")
                }
            }
        }
    }
    func readHeartRate() {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else {
            // Nabız veri tipi tanımlanamadı
            print("Nabız veri tipi tanımlanamadı.")
            return
        }
        
        let heartRateQuery = HKSampleQuery(sampleType: heartRateType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            if let error = error {
                // Veri okuma hatası
                print("Veri okuma hatası: \(error.localizedDescription)")
                return
            }
            
            guard let samples = samples as? [HKQuantitySample] else {
                // Örnekler çevrilemedi
                return
            }
            
            for sample in samples {
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let heartRateValue = sample.quantity.doubleValue(for: heartRateUnit)
                print("Nabız: \(heartRateValue)")
            }
        }
        
        healthStore.execute(heartRateQuery)
    }
    func readActiveEnergy() {
        guard let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            // Aktif enerji veri tipi tanımlanamadı
            print("Aktif enerji veri tipi tanımlanamadı.")
            return
        }
        
        let activeEnergyQuery = HKSampleQuery(sampleType: activeEnergyType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            if let error = error {
                // Veri okuma hatası
                print("Veri okuma hatası: \(error.localizedDescription)")
                return
            }
            
            guard let samples = samples as? [HKQuantitySample] else {
                // Örnekler çevrilemedi
                return
            }
            
            for sample in samples {
                let activeEnergyUnit = HKUnit.kilocalorie()
                let activeEnergyValue = sample.quantity.doubleValue(for: activeEnergyUnit)
                print("Aktif enerji: \(activeEnergyValue) kcal")
            }
        }
        
        healthStore.execute(activeEnergyQuery)
    }
    func readWalkingRunningDistance() {
        guard let walkingRunningDistanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) else {
            // Yürüme/koşma mesafesi veri tipi tanımlanamadı
            print("Yürüme/koşma mesafesi veri tipi tanımlanamadı.")
            return
        }
        
        let walkingRunningDistanceQuery = HKSampleQuery(sampleType: walkingRunningDistanceType, predicate: nil, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            if let error = error {
                // Veri okuma hatası
                print("Veri okuma hatası: \(error.localizedDescription)")
                return
            }
            
            guard let samples = samples as? [HKQuantitySample] else {
                // Örnekler çevrilemedi
                return
            }
            
            for sample in samples {
                let walkingRunningDistanceUnit = HKUnit.meter()
                let walkingRunningDistanceValue = sample.quantity.doubleValue(for: walkingRunningDistanceUnit)
                print("Yürüme/koşma mesafesi: \(walkingRunningDistanceValue) m")
            }
        }
        
        healthStore.execute(walkingRunningDistanceQuery)
    }




}

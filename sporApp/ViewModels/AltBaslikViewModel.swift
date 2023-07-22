//
//  AltBaslikViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 10.07.2023.
//

import Foundation
import Alamofire
import UIKit
import Firebase

class AltBaslikViewModel {
    var altBaslikList = [AltBaslik]()
    var kategori: Kategoriler?
    var gelen: Int?
    var bosList = [AltBaslik]()
    var searchList = [AltBaslik]()
    var altbaslikViewController: AltBaslikViewController?
    var alerts = AlertAction()
    
    func addFavorite(userID: String, rowData: AltBaslik) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("users").document(userID).collection("favorites")
        
        let data: [String: Any] = [
            "ad": rowData.ad ?? ""
        ]
        
        collectionRef.addDocument(data: data) { (error) in
            if let error = error {
                print("Favori eklenirken hata oluştu: \(error.localizedDescription)")
            } else {
                self.alerts.girisHata(title: "Bilgi", mesaj: "Favori başarıyla eklendi", viewControllers: self.altbaslikViewController)
            }
        }
    }
    
    func fetchData(completion: @escaping (Result<Void, Error>) -> Void) {
        let urlString = "https://www.tekinder.org.tr/bootapp/spor/servis.php?tur=video"
        AF.request(urlString, method: .get).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode([AltBaslikCevap].self, from: data)
                    for x in cevap {
                        if let gelenDeger = x.video {
                            self.altBaslikList.append(gelenDeger)
                        }
                    }
                    for x in self.altBaslikList {
                        if self.gelen == Int(x.katid ?? "") || self.kategori?.id == (x.katid ?? "Değer Yok") {
                            self.bosList.append(x)
                            self.searchList = self.bosList
                        }
                    }
                    completion(.success(()))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}

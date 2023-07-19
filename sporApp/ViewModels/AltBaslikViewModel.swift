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
                print("Favori başarıyla eklendi.")
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
    
    func hata(isim:String){
        
        guard let viewController = altbaslikViewController else {return}
        
        let uyari = UIAlertController(title: "HATA", message: "\(isim) favoriler içerisinde mevcut", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .cancel)
        uyari.addAction(alertAction)
        viewController.present(uyari, animated: true)
    }
}

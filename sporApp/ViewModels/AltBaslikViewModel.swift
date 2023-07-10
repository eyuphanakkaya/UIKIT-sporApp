//
//  AltBaslikViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 10.07.2023.
//

import Foundation
import Alamofire
import UIKit

class AltBaslikViewModel {
    var altBaslikList = [AltBaslik]()
    var kategori: Kategoriler?
    var bosList = [AltBaslik]()
    var searchList = [AltBaslik]()
    
    var altbaslikViewController: AltBaslikViewController?
    
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
                        if self.kategori?.id == x.katid {
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

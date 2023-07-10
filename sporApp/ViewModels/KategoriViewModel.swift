//
//  KategoriViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 10.07.2023.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

class KategoriViewModel {
    func fetchKategoriler(completion: @escaping (Result<[Kategoriler], Error>) -> Void) {
        let urlString = "https://www.tekinder.org.tr/bootapp/spor/servis.php?tur=kategori"
        AF.request(urlString, method: .get).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode([KategoriCevap].self, from: data)
                    let kategoriList = cevap.compactMap { $0.kategori }
                    completion(.success(kategoriList))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Resim indirme hatası: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}


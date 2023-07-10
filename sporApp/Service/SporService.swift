//
//  SporService.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 8.07.2023.
//

import Foundation
import Alamofire

enum KategoriServiceEndPoint: String {
    case BASE_URL = "https://www.tekinder.org.tr/bootapp/spor/servis.php?tur="
    case PATH = "kategori"

    static func katePath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }

}

protocol IKategoriService {
    func fetchDatas()
}

struct KategoriService: IKategoriService {
    func fetchDatas() {
        AF.request(KategoriServiceEndPoint.katePath()).responseDecodable(of: KategoriCevap.self) { (model)
            
        }
    }
}

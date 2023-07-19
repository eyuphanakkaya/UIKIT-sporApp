//
//  YonlendirmeAlert.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 19.07.2023.
//

import Foundation
import UIKit

class YonlendirmeAlert {
    func yonlendir(mesaj:String,viewControllers: UIViewController?,hucreNo:Int,identifier: String){
        guard let viewController = viewControllers else {
            return
        }
        
        let yonlendirUyari = UIAlertController(title: "Yönlendirme", message: mesaj, preferredStyle: .alert)
        let yonlendirAction = UIAlertAction(title: "Tamam", style: .cancel) { _ in
                viewController.performSegue(withIdentifier: identifier, sender: hucreNo)
        }
        let yonlendirIptal = UIAlertAction(title: "İptal", style: .destructive)
        
        yonlendirUyari.addAction(yonlendirAction)
        yonlendirUyari.addAction(yonlendirIptal)
        viewController.present(yonlendirUyari, animated: true)
    }
}

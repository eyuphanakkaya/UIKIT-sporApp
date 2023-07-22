//
//  Alert.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 13.07.2023.
//

import Foundation
import UIKit

class AlertAction {
    func girisHata(title: String,mesaj:String,viewControllers: UIViewController?){
        guard let viewController = viewControllers else {
            return
        }
        
        let hataUyari = UIAlertController(title: title, message: mesaj, preferredStyle: .alert)
        let hataAction = UIAlertAction(title: "Tamam", style: .cancel)
        hataUyari.addAction(hataAction)
        viewController.present(hataUyari, animated: true)
    }
}

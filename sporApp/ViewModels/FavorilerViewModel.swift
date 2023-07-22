//
//  FavorilerViewModel.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 13.07.2023.
//

import Foundation
import Firebase
class FavorilerViewModel {
    
    var alerts = AlertAction()
    var favList = [AltBaslik]()
    var favori = [AltBaslik]()
    
    var favoriViewController: FavorilerViewController?
    
    func fetchFavoriteData(completion: @escaping ([AltBaslik]) -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Kullanıcı oturumu yok.")
            completion([])
            return
        }
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("users").document(currentUserID).collection("favorites")
        
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Favori verileri alınırken hata oluştu: \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("Favori verileri bulunamadı.")
                completion([])
                return
            }
            
            let fetchedFavorites = documents.compactMap { document in
                let data = document.data()
                let altBaslik = AltBaslik(ad: data["ad"] as? String)
                return altBaslik
            }
            
            self.favList = fetchedFavorites
            self.favori.append(contentsOf: fetchedFavorites)
           
            completion(fetchedFavorites)
        }
    }
    
    func deleteData(rowData: AltBaslik, completion: @escaping () -> Void) {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Kullanıcı oturumu yok.")
            return
        }
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("users").document(currentUserID).collection("favorites")
        
        collectionRef.whereField("ad", isEqualTo: rowData.ad ?? "").getDocuments { (snapshot, error) in
            if let error = error {
                print("Favori verileri alınırken hata oluştu: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("Favori verileri bulunamadı.")
                return
            }
            
            for document in documents {
                let documentID = document.documentID
                collectionRef.document(documentID).delete { error in
                    if let error = error {
                        print("Veri silinirken hata oluştu: \(error.localizedDescription)")
                    } else {
                        self.alerts.girisHata(title: "Hata", mesaj: "Veri başarıyla silindi", viewControllers: self.favoriViewController)
                        completion()
                    }
                }
            }
        }
    }
    
    func getFavorite(at index: Int) -> AltBaslik {
        return favList[index]
    }
    
    func getNumberOfFavorites() -> Int {
        return favList.count
    }
}

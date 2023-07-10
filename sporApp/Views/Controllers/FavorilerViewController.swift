//
//  FavorilerViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit
import Firebase

class FavorilerViewController: UIViewController {
    var gelenDeger:AltBaslik?
    var favList = [AltBaslik]()
    var shared = VeriModel.shared
    
    @IBOutlet weak var favTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        favTableView.delegate = self
        favTableView.dataSource = self
        favTableView.backgroundColor = nil
        

       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    func loadData() {
            let defaults = UserDefaults.standard
            if let savedData = defaults.data(forKey: "NewSavedData"),
               let dataList = try? JSONDecoder().decode([AltBaslik].self, from: savedData) {

                favList = dataList
                //print(dataList)
                
            }
            
            // UITableView'yi yeniden yükle
            favTableView.reloadData()
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        let destionationVC = segue.destination as? VideoViewController
        destionationVC?.baslik = favList[indeks!]
       
    }
    func getFavoriler() {
        // Mevcut kullanıcının kimlik bilgisini alın
        if let currentUser = Auth.auth().currentUser {
            let userID = currentUser.uid
            
            // Firestore veritabanına referans oluşturun
            let db = Firestore.firestore()
            
            // "favoriler" koleksiyonuna referans oluşturun
            let collectionRef = db.collection("favoriler")
            
            // Kullanıcının favorilerini temsil eden belgeleri sorgulayın
            collectionRef.whereField("kullaniciGelenId", isEqualTo: userID).getDocuments { (snapshot, error) in
                if let error = error {
                    print("Veri alınamadı: \(error.localizedDescription)")
                    return
                }
                
                // Snapshot'tan belgeleri alın
                guard let documents = snapshot?.documents else {
                    print("Belge bulunamadı")
                    return
                }
                
                // Favoriler dizisini temizleyin
                self.favList.removeAll()
                
                // Belge verilerini döngüyle diziye ekleyin
                for document in documents {
                    let data = document.data()
                    // İlgili verilere erişerek Favori nesnesini oluşturun
                    if let favoriAd = data["favoriAd"] as? String {
                        let favori = AltBaslik(ad: favoriAd)
                        self.favList.append(favori)
                    }
                    // Diğer verileri de burada işleyebilirsiniz
                }
                
                // TableView'i güncelleyin
                DispatchQueue.main.async {
                    self.favTableView.reloadData()
                }
            }
        }
    }

    func convertToAltBaslik(_ data: [String: Any]) -> AltBaslik? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
            let altBaslik = try JSONDecoder().decode(AltBaslik.self, from: jsonData)
            return altBaslik
        } catch {
            print("Veri dönüşüm hatası: \(error.localizedDescription)")
            return nil
        }
    }


}

extension FavorilerViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return favList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gelenVeri = favList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! FavoriTableViewCell
        
        cell.gelenDeger = gelenVeri
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        tableView.rowHeight = 100

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(favList[indexPath.row].ad!)
        /*let vc = storyboard?.instantiateViewController(withIdentifier: "toVideo") as! VideoViewController
        vc.baslik = favList[indexPath.row]

        present(vc, animated: true,completion: nil)*/
        
        performSegue(withIdentifier: "toVideo", sender: indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favKaldir = UIContextualAction(style: .destructive, title: "Favoriden Kaldır") { contextAction, view, boolValue in
            

            
            
        }
        return UISwipeActionsConfiguration(actions: [favKaldir])
    }
    
    
    /*func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favKaldir = UIContextualAction(style: .destructive, title: "Favoriden Kaldır") { contextAction, view, boolValue in
            contextAction.image = UIImage(named: "")
            
            // Favori öğesinin kaldırılması
            let selectedFavorite = self.favList[indexPath.row] // Seçilen favori öğesi
            self.favList.remove(at: indexPath.row) // Favori listesinden kaldırma işlemi
            
            // Güncellenmiş favori listesini UserDefault'a kaydetme
            let defaults = UserDefaults.standard
            if let savedData = defaults.data(forKey: "NewSavedData"),
               var dataList = try? JSONDecoder().decode([AltBaslik].self, from: savedData) {
                
                if let index = dataList.firstIndex(where: { $0.ad == selectedFavorite.ad }) {
                    dataList.remove(at: index)
                    let encodedData = try? JSONEncoder().encode(dataList)
                    defaults.set(encodedData, forKey: "NewSavedData")
                    defaults.synchronize()
                    
                }
            }
            
            // VeriModel içerisinden de seçilen favori öğesini kaldırma
            if let index = VeriModel.shared.dataList.firstIndex(of: selectedFavorite) {
                VeriModel.shared.dataList.remove(at: index)
            }
            
            // UITableView'yi yeniden yükleme
            tableView.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [favKaldir])
    }*/


   
    
}

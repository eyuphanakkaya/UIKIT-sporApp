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
    let db = Firestore.firestore()
    
    @IBOutlet weak var favTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        favTableView.delegate = self
        favTableView.dataSource = self
        favTableView.backgroundColor = nil
        
       
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoriteData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVideo" {
            if let indexPath = sender as? Int {
                let destinationVC = segue.destination as? VideoViewController
                destinationVC?.baslik = favList[indexPath]
            }
        }
    }


    func fetchFavoriteData() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {
            print("Kullanıcı oturumu yok.")
            return
        }
        
        let db = Firestore.firestore()
        let collectionRef = db.collection("users").document(currentUserID).collection("favorites")
        
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Favori verileri alınırken hata oluştu: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("Favori verileri bulunamadı.")
                return
            }
            
            // Favori verilerini diziye ekle
            self.favList = documents.compactMap { document in
                let data = document.data()
                let altBaslik = AltBaslik(ad: data["ad"] as? String)
                return altBaslik
            }
            
            // Tabloyu güncelle
            self.favTableView.reloadData()
        }
    }
    func deleteData(rowData: AltBaslik, indexPath: IndexPath) {
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
                        print("Veri başarıyla silindi.")
                        
                        // Silinen veriyi favori listesinden kaldır
                        self.favList.remove(at: indexPath.row)
                        self.favTableView.reloadData()
                    }
                }
            }
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
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil") { (action, view, completion) in
            let rowData = self.favList[indexPath.row]
            self.deleteData(rowData: rowData, indexPath: indexPath)
            completion(true)
        }
        
      //  deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}

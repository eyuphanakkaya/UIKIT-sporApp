//
//  AltBaslikViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit
import Firebase
import Alamofire

class AltBaslikViewController: UIViewController {

    
    var altBaslikViewModel = AltBaslikViewModel()
    var favViewModel = FavorilerViewModel()
    var kategori: Kategoriler?
    var gelen: Int?
    let db = Firestore.firestore()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        altBaslikListe()
        searchBar.barTintColor = UIColor.systemGray
        searchBar.layer.cornerRadius = 20
        searchBar.layer.masksToBounds = true

    
        tableView.backgroundColor = nil
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        

    }
    func altBaslikListe() {
        if let gelenInt = gelen as? Int {
            altBaslikViewModel.gelen = gelenInt
        } else if let kategoriString = kategori as? Kategoriler {
            altBaslikViewModel.kategori = kategoriString
        }

        altBaslikViewModel.gelen = gelen // selectedKategori, kategori seçiminizin olduğu bir değişkenin değeridir
        altBaslikViewModel.fetchData { [weak self] result in
            switch result {
            case .success:
                // Veriler başarıyla alındı, View güncellemelerini yapabilirsiniz
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                // Hata durumunda hata işlemlerini gerçekleştirin
                print("Hata: \(error)")
            }
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        if segue.identifier == "toVideoVC" {
            let destionationVC = segue.destination as? VideoViewController
            destionationVC?.baslik = altBaslikViewModel.bosList[indeks!]
            
        } else if segue.identifier == "toMapVC" {
            let destinationVC = segue.destination as? MapsViewController
            destinationVC?.gelenKategori = kategori?.ad
        } 
       
    }
    

    @IBAction func konumBulTiklandi(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }

}

extension AltBaslikViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return altBaslikViewModel.bosList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "altBaslikCell", for: indexPath) as! AltBaslikTableViewCell
    
        cell.altBaslikAdLabel.text = altBaslikViewModel.bosList[indexPath.row].ad
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10
        tableView.rowHeight = 70
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(bosList[indexPath.row].ad!)
        performSegue(withIdentifier: "toVideoVC", sender: indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let rowData = altBaslikViewModel.bosList[indexPath.row]

           let favEkle = UIContextualAction(style: .normal, title: "") { (action, view, completion) in
               guard let currentUserID = Auth.auth().currentUser?.uid else {
                   print("Kullanıcı oturumu yok.")
                   completion(false)
                   return
               }
               if self.favViewModel.favList.contains(where: {$0.ad == rowData.ad  }){
                  print("hata")
               } else {
                   self.altBaslikViewModel.addFavorite(userID: currentUserID, rowData: rowData)
               }
//               for x in self.favViewModel.favList {
//                   for y in self.altBaslikViewModel.bosList {
//                       if x.ad != y.ad {
//                           self.altBaslikViewModel.addFavorite(userID: currentUserID, rowData: rowData)
//                       } else {
//                           print("hata")
//                       }
//                   }
//
//               }


            completion(true)
           }

        favEkle.backgroundColor = .red
        favEkle.image = UIImage(systemName: "heart")

           let configuration = UISwipeActionsConfiguration(actions: [favEkle])
           return configuration
       }



    

    


}
extension AltBaslikViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            let filteredList = altBaslikViewModel.bosList.filter { altBaslik in
                return altBaslik.ad?.lowercased().contains(searchText.lowercased()) ?? false
            }
                altBaslikViewModel.bosList = filteredList
        } else {
            
            altBaslikViewModel.bosList = altBaslikViewModel.searchList
        }
        
        tableView.reloadData()
    }
}


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
    var favoriler: [String: [AltBaslik]] = [:]

    var shared = VeriModel.shared
    var kategori:Kategoriler?
    var List = VeriModel.shared.dataList
    let db = Firestore.firestore()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(kategori?.id!)

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
        altBaslikViewModel.kategori = kategori // selectedKategori, kategori seçiminizin olduğu bir değişkenin değeridir
        altBaslikViewModel.fetchData { [weak self] result in
            switch result {
            case .success:
                // Veriler başarıyla alındı, View güncellemelerini yapabilirsiniz
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                // Hata durumunda hata işlemlerini gerçekleştirin
                print("Hata: \(error.localizedDescription)")
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
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        tableView.rowHeight = 100

        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(bosList[indexPath.row].ad!)
        performSegue(withIdentifier: "toVideoVC", sender: indexPath.row)
        
    }
    /*func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let favEkle = UIContextualAction(style: .normal, title: "") { contextualAction, view, boolValue in
            
            let gidenDeger = self.altBaslikViewModel.bosList[indexPath.row]

            let defaults = UserDefaults.standard
            if var dataList = defaults.data(forKey: "NewSavedData").flatMap({ try? JSONDecoder().decode([AltBaslik].self, from: $0) }) {
                if !dataList.contains(where: { $0.ad == gidenDeger.ad }) {
                    // Kaydedilmek istenilen veri dataList içinde kayıtlı değilse kaydetme işlemi yapılır
                    VeriModel.shared.dataList.append(gidenDeger)
                    dataList.append(gidenDeger) // Yeni veriyi dataList'e ekleyin
                    if let encodedData2 = try? JSONEncoder().encode(dataList) {
                        defaults.set(encodedData2, forKey: "NewSavedData") // Güncellenmiş veriyi UserDefaults'a kaydedin
                        defaults.synchronize()
                    }
                } else {
                    // Kaydedilmek istenilen veri dataList içinde zaten kayıtlıysa bir işlem yapma
                    self.altBaslikViewModel.hata(isim:self.altBaslikViewModel.bosList[indexPath.row].ad!)
                }
            }
        }

        favEkle.backgroundColor = .red
        favEkle.image = UIImage(named: "heart")

        return UISwipeActionsConfiguration(actions: [favEkle])

    }*/
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let rowData = altBaslikViewModel.bosList[indexPath.row]

           let favEkle = UIContextualAction(style: .normal, title: "Favoriye Ekle") { (action, view, completion) in
               guard let currentUserID = Auth.auth().currentUser?.uid else {
                   print("Kullanıcı oturumu yok.")
                   completion(false)
                   return
               }
               
            self.altBaslikViewModel.addFavorite(userID: currentUserID, rowData: rowData)
            completion(true)
           }
           
        favEkle.backgroundColor = .red
        favEkle.image = UIImage(named: "heart")
           
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


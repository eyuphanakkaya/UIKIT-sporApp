//
//  FavorilerViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit

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
        performSegue(withIdentifier: "toVideoVC", sender: indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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
    }

   
    
}

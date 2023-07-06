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


    var shared = VeriModel.shared
    var altBaslikList = [AltBaslik]()
    var bosList = [AltBaslik]()
    var searchList = [AltBaslik]()
    var kategori:Kategoriler?
    var List = VeriModel.shared.dataList
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(kategori?.id!)

        altBaslikListele()
        searchBar.barTintColor = UIColor.systemGray
        searchBar.layer.cornerRadius = 20
        searchBar.layer.masksToBounds = true

        
        
        tableView.backgroundColor = nil
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        if segue.identifier == "toVideoVC" {
            let destionationVC = segue.destination as? VideoViewController
            destionationVC?.baslik = bosList[indeks!]
        } else if segue.identifier == "toMapVC" {
            let destinationVC = segue.destination as? MapsViewController
            destinationVC?.gelenKategori = kategori?.ad
        }
       
    }
    
    
    
    @IBAction func konumBulTiklandi(_ sender: Any) {
        performSegue(withIdentifier: "toMapVC", sender: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedData = UserDefaults.standard.data(forKey: "NewSavedData"),
           let dataList = try? JSONDecoder().decode([AltBaslik].self, from: savedData) {
            VeriModel.shared.dataList = dataList
        
            
        }
    }
    
    func hata(isim:String){
        let uyari = UIAlertController(title: "HATA", message: "\(isim) favoriler içerisinde mevcut", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Tamam", style: .cancel)
        uyari.addAction(alertAction)
        present(uyari, animated: true)
    }
    func altBaslikListele(){
        var urlString = "https://www.tekinder.org.tr/bootapp/spor/servis.php?tur=video"
        AF.request(urlString,method: .get).response { response in
            if let error = response.error {
                print("HATA: \(error)")
            }
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode([AltBaslikCevap].self, from: data)
                    for x in cevap {
                        if let gelenDeger = x.video {
                            self.altBaslikList.append(gelenDeger)
                        }
                    }
                    for x in self.altBaslikList {
                        if self.kategori?.id == x.katid {
                            print(x)
                            self.bosList.append(x)
                            self.searchList = self.bosList
                        }
                    }
                    self.tableView.reloadData() 
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    

    
}

extension AltBaslikViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return bosList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "altBaslikCell", for: indexPath) as! AltBaslikTableViewCell
    
        cell.altBaslikAdLabel.text = bosList[indexPath.row].ad
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        tableView.rowHeight = 100

        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(bosList[indexPath.row].ad!)
        performSegue(withIdentifier: "toVideoVC", sender: indexPath.row)
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let favEkle = UIContextualAction(style: .normal, title: "") { contextualAction, view, boolValue in
            
            let gidenDeger = self.bosList[indexPath.row]

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
                    self.hata(isim: self.bosList[indexPath.row].ad!)
                }
            }
        }

        favEkle.backgroundColor = .red
        favEkle.image = UIImage(named: "heart")

        return UISwipeActionsConfiguration(actions: [favEkle])

    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favEkle = UIContextualAction(style: .normal, title: "") { contextualAction, view, boolValue in
            
            

        }
        favEkle.backgroundColor = .red
        favEkle.image = UIImage(named: "heart")

        return UISwipeActionsConfiguration(actions: [favEkle])
    }

}
extension AltBaslikViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text, !searchText.isEmpty {
            let filteredList = bosList.filter { altBaslik in
                return altBaslik.ad?.lowercased().contains(searchText.lowercased()) ?? false
            }
            bosList = filteredList
        } else {
            
            bosList = searchList
        }
        
        tableView.reloadData()
    }
}


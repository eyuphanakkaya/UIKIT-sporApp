//
//  AltBaslikViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit

class AltBaslikViewController: UIViewController {


    var shared = VeriModel.shared
    var altBaslikList = [AltBaslik]()
    var bosList = [AltBaslik]()
    var searchList = [AltBaslik]()
    var kategori:Kategoriler?
    var altBaslikListe = AltBaslikEklendi()
    var List = VeriModel.shared.dataList
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(kategori?.id!)

            
        altBaslikEkle()

        searchBar.barTintColor = UIColor.systemGray
        searchBar.layer.cornerRadius = 20
        searchBar.layer.masksToBounds = true
        
        for x in altBaslikList {
            if kategori?.id == x.kategori_id {
                bosList.append(x)
                searchList = bosList
            }
        }
        
        tableView.backgroundColor = nil
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        

    }
    func altBaslikEkle(){
        altBaslikList.append(altBaslikListe.a1)
        altBaslikList.append(altBaslikListe.a2)
        altBaslikList.append(altBaslikListe.a3)
        altBaslikList.append(altBaslikListe.a4)
        altBaslikList.append(altBaslikListe.a5)
        altBaslikList.append(altBaslikListe.a6)
        altBaslikList.append(altBaslikListe.a7)
        altBaslikList.append(altBaslikListe.a8)
        altBaslikList.append(altBaslikListe.a9)
        altBaslikList.append(altBaslikListe.a10)
        altBaslikList.append(altBaslikListe.a11)
        altBaslikList.append(altBaslikListe.a12)
        altBaslikList.append(altBaslikListe.a13)
        altBaslikList.append(altBaslikListe.a14)
        altBaslikList.append(altBaslikListe.a15)
            
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
        
        let favEkle = UIContextualAction(style: .normal, title: "") {  contextualAction, view, boolValue in
            let gidenDeger = self.bosList[indexPath.row]
            
        
                
                    VeriModel.shared.dataList.append(gidenDeger)
                    let defaults = UserDefaults.standard
                    if let encodedData2 = try? JSONEncoder().encode(VeriModel.shared.dataList) {
            if !VeriModel.shared.dataList.contains(where: { $0.ad == gidenDeger.ad }) {
                    // Kaydedilmek istenilen veri dataList içinde kayıtlı değilse kaydetme işlemi yapılır
                    defaults.set(encodedData2, forKey: "NewSavedData")
                    defaults.synchronize()
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


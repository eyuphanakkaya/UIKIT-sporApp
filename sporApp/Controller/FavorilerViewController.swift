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
            if let savedData = defaults.data(forKey: "SavedData"),
               let dataList = try? JSONDecoder().decode([AltBaslik].self, from: savedData) {
                favList = dataList
                print(dataList)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! FavoriTableViewCell
    
        cell.gelenDeger = favList[indexPath.row]
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
   
    
}

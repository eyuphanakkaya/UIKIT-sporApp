//
//  AltBaslikViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit

class AltBaslikViewController: UIViewController {


   
    var altBaslikList = [AltBaslik]()
    var bosList = [AltBaslik]()
    var kategori:Kategoriler?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(kategori?.id!)
        let a1 = AltBaslik(id: 1, ad: "Bench Press", resim: "", kategori_id: 1,aciklama: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",ytId: "rT7DgCr-3pg")
        let a2 = AltBaslik(id: 1, ad: "Squat", resim: "", kategori_id: 1,aciklama: "uzun metin",ytId: "SW_C1A-rejs")
        let a3 = AltBaslik(id: 1, ad: "Incline Bench Press", resim: "", kategori_id: 1,aciklama: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",ytId: "SrqOu55lrYU")
        let a4 = AltBaslik(id: 1, ad: "Over head Press", resim: "", kategori_id: 1,aciklama: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",ytId: "Vyt2QdsR7E")
        let a5 = AltBaslik(id: 1, ad: "Deadlift", resim: "", kategori_id: 1,aciklama: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.",ytId: "JCXUYuzwNrM")

        
        
        
        altBaslikList.append(a1)
        altBaslikList.append(a2)
        altBaslikList.append(a3)
        altBaslikList.append(a4)
        altBaslikList.append(a5)

        
        searchBar.barTintColor = UIColor.systemGray
        searchBar.layer.cornerRadius = 20
        searchBar.layer.masksToBounds = true
        
        for x in altBaslikList {
            if kategori?.id == x.kategori_id {
                bosList.append(x)
                print(x.ad!)
            }
        }
        
        tableView.backgroundColor = nil
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let destionationVC = segue.destination as? VideoViewController
        destionationVC?.baslik = bosList[indeks!]

        
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


}
extension AltBaslikViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            
        }
    }
}

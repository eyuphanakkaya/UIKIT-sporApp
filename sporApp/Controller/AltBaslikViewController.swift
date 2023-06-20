//
//  AltBaslikViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit

class AltBaslikViewController: UIViewController {

    var altBaslikList = [AltBaslik]()
    var kategori:Kategoriler?
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(kategori?.ad!)
        let a1 = AltBaslik(id: 1, ad: "Bench Press", resim: "", kategori_ad: kategori?.ad)
        let a2 = AltBaslik(id: 2, ad: "Barball Row", resim: "", kategori_ad: kategori?.ad)
        let a3 = AltBaslik(id: 3, ad: "Squat", resim: "", kategori_ad: kategori?.ad)
        let a4 = AltBaslik(id: 3, ad: "Kulaç", resim: "", kategori_ad: kategori?.ad)
        let a5 = AltBaslik(id: 3, ad: "Squat", resim: "", kategori_ad: kategori?.ad)
        let a6 = AltBaslik(id: 3, ad: "Squat", resim: "", kategori_ad: kategori?.ad)
        let a7 = AltBaslik(id: 3, ad: "Squat", resim: "", kategori_ad: kategori?.ad)
        
        altBaslikList.append(a1)
        altBaslikList.append(a2)
        altBaslikList.append(a3)
        
    
    
        tableView.backgroundColor = nil
        tableView.delegate = self
        tableView.dataSource = self

    }
    

}

extension AltBaslikViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return altBaslikList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "altBaslikCell", for: indexPath) as! AltBaslikTableViewCell

        cell.altBaslikAdLabel.text = altBaslikList[indexPath.row].ad
        return cell
    }
    
    

}

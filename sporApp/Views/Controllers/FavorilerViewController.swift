//
//  FavorilerViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit
import Firebase
import HealthKit

class FavorilerViewController: UIViewController {
   
    var favGelenList = [AltBaslik]()
    var favViewModel = FavorilerViewModel()
    
    @IBOutlet weak var favTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favViewModel.favoriViewController = self
        favTableView.delegate = self
        favTableView.dataSource = self
        favTableView.backgroundColor = nil
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        DispatchQueue.main.async {
//            print("Fav sayfası gelen veriler\(self.favViewModel.favori) ")
//        }
        fetchFavoriteData()
    }
    func fetchFavoriteData() {
        favViewModel.fetchFavoriteData { [weak self] (fetchedFavorites) in
            self!.favGelenList = fetchedFavorites// Ana iş parçacığına dönüş yaparak güncellemeyi yapın
            self?.favTableView.reloadData()

        
        }
    }
    func deleteData(rowData: AltBaslik, indexPath: IndexPath) {
        favViewModel.deleteData(rowData: rowData) { [weak self] in
            self?.favViewModel.favList.remove(at: indexPath.row)
                self?.favTableView.reloadData()
            }
        }   
}
extension FavorilerViewController: UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return favViewModel.getNumberOfFavorites()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gelenVeri = self.favViewModel.getFavorite(at: indexPath.row)
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriCell", for: indexPath) as! FavoriTableViewCell
        
        cell.gelenDeger = gelenVeri
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 10
        tableView.rowHeight = 70

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//       // print(favList[indexPath.row].ad!)
//        /*let vc = storyboard?.instantiateViewController(withIdentifier: "toVideo") as! VideoViewController
//        vc.baslik = favList[indexPath.row]
//
//        present(vc, animated: true,completion: nil)*/
//        
//        performSegue(withIdentifier: "toVideo", sender: indexPath.row)
//        
//    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, view, completion) in
            let rowData = self.favViewModel.favList[indexPath.row]
            self.deleteData(rowData: rowData, indexPath: indexPath)
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}

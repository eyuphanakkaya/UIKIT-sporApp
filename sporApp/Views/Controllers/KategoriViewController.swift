//
//  KategoriViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit
import Alamofire
import AlamofireImage
import Firebase

class KategoriViewController: UIViewController {

    var kategoriList = [Kategoriler]()
    var kategoriViewModel = KategoriViewModel()
    
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kategoriListele()
        kategoriCollectionView.backgroundColor = nil
        kategoriCollectionView.dataSource = self
        kategoriCollectionView.delegate = self
        tasarim()
    }
    
    func tasarim(){
        let tasarim = UICollectionViewFlowLayout()

        let genislik = self.kategoriCollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.itemSize = CGSize(width: (genislik - 50), height: (genislik - 30)/2)
        tasarim.minimumLineSpacing = 5
        tasarim.minimumInteritemSpacing = 5

        kategoriCollectionView.collectionViewLayout = tasarim
    }
    func kategoriListele() {
        kategoriViewModel.fetchKategoriler { [weak self] result in
            switch result {
            case .success(let kategoriler):
                print(kategoriler)
                self?.kategoriList = kategoriler
                DispatchQueue.main.async {
                    self?.kategoriCollectionView.reloadData()
                }
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? String
        let toDestination = segue.destination as? AltBaslikViewController
        toDestination?.kategori = kategoriList[Int(indeks!)! - 1]
        
    }

}

extension KategoriViewController : UICollectionViewDelegate,UICollectionViewDataSource,UITabBarDelegate,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kategoriList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KategoriCell", for: indexPath) as! KategoriCVCell
        let kategori = kategoriList[indexPath.row]
        
        cell.kategoriAdLabel.text = kategori.ad
        
        if let resimURL = URL(string: kategori.resim ?? "") {
            
            kategoriViewModel.downloadImage(from: resimURL) { image in
                DispatchQueue.main.async {
                    if let downloadedImage = image {
                        cell.imageView.image = downloadedImage
                    }
                }
            }
        }
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 3
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hucreNo = kategoriList[indexPath.row].id
        self.performSegue(withIdentifier: "toAltBaslik", sender: hucreNo)
    }
    
}

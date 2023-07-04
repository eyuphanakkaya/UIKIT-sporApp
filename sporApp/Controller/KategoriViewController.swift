//
//  KategoriViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit



class KategoriViewController: UIViewController {

    var kategoriList = [Kategoriler]()
    
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true
        
        let k1 = Kategoriler(id: 1, ad: "Fitness", resim: "gym")
        let k2 = Kategoriler(id: 2, ad: "Pilates", resim: "pilates")
        let k3 = Kategoriler(id: 3, ad: "Kick Boks", resim: "kick")
        let k4 = Kategoriler(id: 4, ad: "Yoga", resim: "yoga")
        let k5 = Kategoriler(id: 5, ad: "Bale", resim: "bale")
        
        kategoriList.append(k1)
        kategoriList.append(k2)
        kategoriList.append(k3)
        kategoriList.append(k4)
        kategoriList.append(k5)

        
        navigationItem.title = ""
        kategoriCollectionView.backgroundColor = nil
        kategoriCollectionView.dataSource = self
        kategoriCollectionView.delegate = self

        let tasarim = UICollectionViewFlowLayout()
        
        let genislik = self.kategoriCollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //(genislik-30)/2*1.85
        tasarim.itemSize = CGSize(width: (genislik - 30 )/2, height: (genislik - 30 )/2)
        
        tasarim.minimumLineSpacing = 5
        tasarim.minimumInteritemSpacing = 5
        
        kategoriCollectionView.collectionViewLayout = tasarim
        
       

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let toDestination = segue.destination as? AltBaslikViewController
        toDestination?.kategori = kategoriList[indeks! - 1]
        
    }
}

extension KategoriViewController : UICollectionViewDelegate,UICollectionViewDataSource,UITabBarDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kategoriList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KategoriCell", for: indexPath) as! KategoriCVCell
        cell.setUp(kate: kategoriList[indexPath.row])
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 3
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hucreNo = kategoriList[indexPath.row].id
        self.performSegue(withIdentifier: "toAltBaslik", sender: hucreNo)
    }
    
    
}

//
//  KategoriViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 17.06.2023.
//

import UIKit
import Alamofire
import AlamofireImage





class KategoriViewController: UIViewController {

    var kategoriList = [Kategoriler]()
    
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isToolbarHidden = true
        
        kategoriListele()
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
        let indeks = sender as? String
        let toDestination = segue.destination as? AltBaslikViewController
        toDestination?.kategori = kategoriList[Int(indeks!)! - 1]
        
    }

    func kategoriListele() {
        AF.request("https://www.tekinder.org.tr/bootapp/spor/servis.php?tur=kategori", method: .get).response { response in
            if let error = response.error {
                print("HATA: \(error)")
                return
            }
            
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode([KategoriCevap].self, from: data)
                    for item in cevap {
                        if let kategori = item.kategori {
                            self.kategoriList.append(kategori)
                        }
                    }
                    self.kategoriCollectionView.reloadData()
                } catch let error {
                    print("HATA: \(error)")
                }
            }
        }
    }


    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        AF.request(url).responseImage { response in
            switch response.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Resim indirme hatası: \(error.localizedDescription)")
                completion(nil)
            }
        }
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
        let kategori = kategoriList[indexPath.row]
        
        cell.kategoriAdLabel.text = kategori.ad
        
        if let resimURL = URL(string: kategori.resim ?? "") {
            downloadImage(from: resimURL) { image in
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

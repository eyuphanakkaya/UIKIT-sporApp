//
//  ResultViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 21.06.2023.
//

import UIKit
import CoreLocation

protocol ResultViewControllerDelegate:AnyObject {
    func didTapPlace(with coordinate:CLLocationCoordinate2D)
}
class ResultViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    weak var delegate : ResultViewControllerDelegate?
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    var placeList: [Places] = []
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func update(with places: [Places]) {
        self.tableView.isHidden = false
        self.placeList = places
        print(placeList.count)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        placeList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = placeList[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.isHidden = true
        
        let places = placeList[indexPath.row]
        
        GooglePlacesManager.shared.resolveLocation(for: places) {[weak self] result in
            switch result {
            case .success(let coordinate):
                
                DispatchQueue.main.async {
                    self!.delegate?.didTapPlace(with: coordinate)
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}

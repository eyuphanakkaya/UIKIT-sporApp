//
//  ViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 16.06.2023.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var myLoginView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myLoginView.contentMode = .scaleToFill
        myLoginView.loopMode = .loop
        myLoginView.play()
        myLoginView.backgroundColor = nil
        navigationItem.title = "Giriş Paneli"
        
    }
    


}


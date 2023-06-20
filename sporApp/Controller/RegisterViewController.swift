//
//  RegisterViewController.swift
//  sporApp
//
//  Created by Eyüphan Akkaya on 16.06.2023.
//

import UIKit
import Lottie

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerView: LottieAnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()

        registerView.contentMode = .scaleToFill
        registerView.loopMode = .loop
        registerView.play()
    }
    



}

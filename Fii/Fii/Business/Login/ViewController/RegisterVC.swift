//
//  RegisterVC.swift
//  Fii
//
//  Created by mac on 2019/3/14.
//  Copyright © 2019 Liu Tao. All rights reserved.
//

import UIKit
import Then
import SnapKit

class RegisterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupView() {
        
        view.backgroundColor = UIColor.white
    }
}

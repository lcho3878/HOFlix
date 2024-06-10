//
//  CreditViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit

class CreditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "출연/제작"
    }
    


}

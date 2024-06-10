//
//  TrendViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit

class TrendViewController: UIViewController {

    private let movieSearchBar: UITextField = {
        let view = UITextField()
        let left = UIButton()
        left.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        view.leftView = left
        view.leftViewMode = .always
        
        let right = UIButton()
        right.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.rightView = right
        view.rightViewMode = .always
        
        return view
    }()
    
    private let movieTableView: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = .lightGray
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureHierarchy()
        configureLayout()
        movieTableView.delegate = self
        movieTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        movieSearchBar.underlined(1, .lightGray)
    }

    private func configureHierarchy() {
        view.addSubview(movieSearchBar)
        view.addSubview(movieTableView)
    }
    
    private func configureLayout() {
        movieSearchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(50)
        }
        
        movieTableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(movieSearchBar.snp.bottom)
        }
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
    }


}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

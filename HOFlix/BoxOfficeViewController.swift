//
//  BoxOfficeViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import UIKit
import SnapKit

class BoxOfficeViewController: UIViewController {

    private let searchTextField: UITextField = {
        let view = UITextField()
        view.textColor = .white
        view.placeholder = "날짜를 입력해주세요"
        return view
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let boxTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configreHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTextField.underlined(2, .white)
    }
    
    private func configreHierarchy() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(boxTableView)
    }
    
    private func configureLayout() {
        searchButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.trailing.equalTo(searchButton).inset(90)
            $0.height.equalTo(searchButton)
        }
        
        boxTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black
    }
    
    private func configureTableView() {
        boxTableView.delegate = self
        boxTableView.dataSource = self
    }

}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}


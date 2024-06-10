//
//  CreditViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit

class CreditViewController: UIViewController {
    

    private let backImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let movieTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Squid Game"
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = .boldSystemFont(ofSize: 20)
        return lb
    }()
    
    private let posterImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let contentTableView: UITableView = {
        let tb = UITableView()
        return tb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierarchy()
        configureLayout()
        configureTableView()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "출연/제작"
    }
    
    private func configureHierarchy() {
        view.addSubview(backImageView)
        backImageView.addSubview(movieTitleLabel)
        backImageView.addSubview(posterImageView)
        view.addSubview(contentTableView)
    }
    
    private func configureLayout() {
        
        backImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalToSuperview().dividedBy(4)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(movieTitleLabel).offset(8)
            $0.width.equalTo(backImageView).dividedBy(4)
        }
        
        contentTableView.snp.makeConstraints {
            $0.top.equalTo(backImageView.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
        
        
        
    }
    
    private func configureTableView() {
        contentTableView.dataSource = self
        contentTableView.delegate = self
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.register(OverViewCell.self, forCellReuseIdentifier: OverViewCell.id)
    }
    


}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "OverView"}
        else { return "Cast" }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.id) as? OverViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        }
        else {
            return UITableViewCell()
        }
    }
    
}

extension CreditViewController: OverViewCellDelegate {
    func updateTableView() {
        contentTableView.reloadData()
    }
}

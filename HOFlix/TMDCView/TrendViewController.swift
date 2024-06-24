//
//  TrendViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit

class TrendViewController: UIViewController {
    
    private var movieList: [MovieInfo] = [] {
        didSet{
            movieTableView.reloadData()
        }
    }

    private lazy var movieSearchBar: UITextField = {
        let movieSearchBar = UITextField()
        let leftButton = UIButton()
        leftButton.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        leftButton.addTarget(self, action: #selector(buttonclick), for: .touchUpInside)
        movieSearchBar.leftView = leftButton
        movieSearchBar.leftViewMode = .always
        
        let rightButton = UIButton()
        rightButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        movieSearchBar.rightView = rightButton
        movieSearchBar.rightViewMode = .always
        
        return movieSearchBar
    }()
    
    private let movieTableView: UITableView = {
        let movieTableView = UITableView()

        return movieTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierarchy()
        configureLayout()
        configureTableView()
        callRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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
            $0.top.equalTo(view).offset(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(50)
        }
        
        movieTableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(movieSearchBar.snp.bottom).offset(8)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonDisplayMode = .minimal
    }
    
}

extension TrendViewController {
    private func callRequest() {
        TMDBManager.shared.callTrendRequest {
            self.movieList = $0.results
        }
    }
}

extension TrendViewController {
    @objc
    private func buttonclick() {
        print(#function)
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.id)
        movieTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.id, for: indexPath) as? TrendTableViewCell else { return UITableViewCell() }
        let data = movieList[indexPath.row]
        cell.configureData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let creditVC = CreditViewController()
        creditVC.movie = movieList[indexPath.row]
        navigationController?.pushViewController(creditVC, animated: true)
    }
    
    
}

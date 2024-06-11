//
//  TrendViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire

class TrendViewController: UIViewController {
    
    private var movieList: [MovieInfo] = [] {
        didSet{
            movieTableView.reloadData()
        }
    }

    private let movieSearchBar: UITextField = {
        let view = UITextField()
        let left = UIButton()
        left.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        left.addTarget(self, action: #selector(buttonclick), for: .touchUpInside)
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
    
    private func configureTableView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.id)
        movieTableView.rowHeight = UITableView.automaticDimension
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
    
    private func configure() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black
        navigationItem.backButtonDisplayMode = .minimal
    }

    private func callRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/day"
        let headers = HTTPHeaders([
            "Authorization": APIKey.tmdbToken,
            "accept": "application/json"
        ])
        let param: Parameters = [
            "language": "ko-KR"
        ]
        AF.request(url, parameters: param, headers: headers).responseDecodable(of: MovieResult.self) { response in
            switch response.result {
            case .success(let value):
                self.movieList = value.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func callRequest(_ text: String) {
        
    }
    
    @objc
    private func buttonclick() {
        print(#function)
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
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

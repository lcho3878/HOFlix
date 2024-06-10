//
//  CreditViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class CreditViewController: UIViewController {
    var movie: MovieInfo!
    
    private var castList: [Cast] = [] {
        didSet {
            contentTableView.reloadData()
        }
    }

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
        callRequest(movie.id)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "출연/제작"
        
        backImageView.kf.setImage(with: movie.backImageURL)
        posterImageView.kf.setImage(with: movie.posterImageURL)
        movieTitleLabel.text = movie.title
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
        contentTableView.register(CastCell.self, forCellReuseIdentifier: CastCell.id)
    }
    
    private func callRequest(_ id: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(String(id))/credits"
        let params: Parameters = [
            "language" : "ko-KR"
        ]
        let headers: HTTPHeaders = [
            "Authorization": APIKey.tmdbToken,
            "accept": "application/json"
        ]
        AF.request(url, parameters: params, headers: headers)
            .responseDecodable(of: CastResult.self) { response in
            switch response.result {
            case .success(let v):
                self.castList = v.cast
            case .failure(let e):
                print(e)
            }
        }
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
            return castList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.id) as? OverViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configureData(movie)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.id, for: indexPath) as? CastCell else {
                return UITableViewCell()
            }
            let data = castList[indexPath.row]
            cell.configureData(data)
            return cell
        }
    }
    
}

extension CreditViewController: OverViewCellDelegate {
    func updateTableView() {
        contentTableView.reloadData()
    }
}

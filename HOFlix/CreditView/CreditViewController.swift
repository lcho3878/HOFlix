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
    
    private var recommendList: [MovieInfo] = []{
        didSet {
            recommendMovieCollectionView.reloadData()
        }
    }
    
    private var similarList: [MovieInfo] = []{
        didSet {
            similarMovieCollectionView.reloadData()
        }
    }

    private var castList: [Cast] = [] {
        didSet {
            contentTableView.reloadData()
        }
    }

    private let backImageView: UIImageView = {
        let backImageView = UIImageView()
        backImageView.backgroundColor = .lightGray
        backImageView.contentMode = .scaleAspectFill
        return backImageView
    }()
    
    private let movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.text = "Squid Game"
        movieTitleLabel.textColor = .white
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.font = .boldSystemFont(ofSize: 20)
        return movieTitleLabel
    }()
    
    private let posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.backgroundColor = .white
        posterImageView.contentMode = .scaleAspectFill
        return posterImageView
    }()
    
    private let layout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let n: CGFloat = 5
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - (n - 1) * spacing) / n
        layout.itemSize = CGSize(width: width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        return layout
    }()
    
    private lazy var recommendMovieCollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private lazy var similarMovieCollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let contentTableView: UITableView = {
        let contentTableView = UITableView()
        return contentTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierarchy()
        configureLayout()
        configureCollectionView()
        configureTableView()
        callRequests()
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
        view.addSubview(recommendMovieCollectionView)
        view.addSubview(similarMovieCollectionView)
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
        
        recommendMovieCollectionView.snp.makeConstraints {
            $0.top.equalTo(backImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        similarMovieCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendMovieCollectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        contentTableView.snp.makeConstraints {
            $0.top.equalTo(similarMovieCollectionView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
 
    }

}

extension CreditViewController {
    private func callRequests() {
        TMDBManager.shared.callCastRequest(movie.id) {
            self.castList = $0.cast
        }
        TMDBManager.shared.callRecommendRequest(movie.id) {
            self.recommendList = $0.results
        }
        TMDBManager.shared.callSimilarRequest(movie.id) {
            self.similarList = $0.results
        }
    }
}

extension CreditViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        recommendMovieCollectionView.delegate = self
        recommendMovieCollectionView.dataSource = self
        recommendMovieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
        similarMovieCollectionView.delegate = self
        similarMovieCollectionView.dataSource = self
        similarMovieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendMovieCollectionView {
            return recommendList.count
        }
        else {
            return similarList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell () }
        let data = collectionView == recommendMovieCollectionView ? recommendList[indexPath.row] : similarList[indexPath.row]
        cell.configureDate(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data: MovieInfo
        let index = indexPath.row
        data = collectionView == recommendMovieCollectionView ? recommendList[index] : similarList[index]
        let credicVC = CreditViewController()
        credicVC.movie = data
        navigationController?.pushViewController(credicVC, animated: true)
    }
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        contentTableView.dataSource = self
        contentTableView.delegate = self
        contentTableView.rowHeight = UITableView.automaticDimension
        contentTableView.register(OverViewCell.self, forCellReuseIdentifier: OverViewCell.id)
        contentTableView.register(CastCell.self, forCellReuseIdentifier: CastCell.id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "OverView" : "Cast"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : castList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? UITableView.automaticDimension : 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.id, for: indexPath) as? OverViewCell else {
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

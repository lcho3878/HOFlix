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

final class CreditViewController: UIViewController {
    var movie: MovieInfo!
    
    private var movieList: [[MovieInfo]] = [[],[]]

    private var castList: [Cast] = []
    
    private var previewKey: String?

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
    
    private lazy var previewButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "미리보기"
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        configuration.buttonSize = .small
        let bt = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.clickPreviewButton()
        }))
        return bt
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
        configureTableView()
        callRequests()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.title = "출연/제작"
        
        backImageView.kf.setImage(with: movie.backImageURL)
        posterImageView.kf.setImage(with: movie.posterImageURL)
        movieTitleLabel.text = movie.title
    }
    
    private func configureHierarchy() {
        view.addSubview(backImageView)
        backImageView.addSubview(movieTitleLabel)
        backImageView.addSubview(posterImageView)
        view.addSubview(previewButton)
        view.addSubview(contentTableView)
    }
    
    private func configureLayout() {
        
        backImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalToSuperview().dividedBy(4)
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.height.equalTo(20)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(movieTitleLabel).offset(8)
            $0.width.equalTo(backImageView).dividedBy(4)
        }
        
        previewButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(backImageView).inset(8)
        }
        
        contentTableView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
 
    }

}

extension CreditViewController {
    private func callRequests() {
        let group = DispatchGroup()
        group.enter()
        TMDBManager.shared.callMovieRequest(api: .credits(movieID: movie.id), type: CastResult.self) {
            self.castList = $0.cast
            group.leave()
        }
        group.enter()

        TMDBManager.shared.callMovieRequest(api: .recommendations(movieID: movie.id), type: MovieResult.self) {
            self.movieList[0] = $0.results
            group.leave()
        }
        group.enter()

        TMDBManager.shared.callMovieRequest(api: .similar(movieID: movie.id), type: MovieResult.self) {
            self.movieList[1] = $0.results
            group.leave()
        }
        
        group.enter()
        TMDBManager.shared.callMovieRequest(api: .videos(movieID: movie.id), type: VideoResult.self) {
            self.previewButton.isHidden = $0.results.isEmpty
            if let firstItem = $0.results.first {
                self.previewKey = firstItem.key
            }
            group.leave()
        }

        group.notify(queue: .main) {
            self.contentTableView.reloadData()
        }
    }
}

extension CreditViewController {
    private func clickPreviewButton() {
        guard let previewKey = previewKey else { return }
        let previewVC = PreviewController()
        previewVC.previewKey = previewKey
        navigationController?.pushViewController(previewVC, animated: true)
        
    }
}

extension CreditViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.id, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell () }
        let data = movieList[collectionView.tag][indexPath.item]
        cell.configureDate(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        let data = movieList[collectionView.tag][index]
        let credicVC = CreditViewController()
        credicVC.movie = data
        navigationController?.pushViewController(credicVC, animated: true)
    }
    
}

extension CreditViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        contentTableView.dataSource = self
        contentTableView.delegate = self
        contentTableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.id)
        contentTableView.register(OverViewCell.self, forCellReuseIdentifier: OverViewCell.id)
        contentTableView.register(CastCell.self, forCellReuseIdentifier: CastCell.id)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return movieList[section].isEmpty ? nil : "Recommendation"
        case 1: return movieList[section].isEmpty ? nil : "Similar"
        case 2: return "OverView"
        case 3: return "Cast"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 3 ? castList.count : 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        switch section {
        case 0, 1:
            return  movieList[section].isEmpty ? 0 : 100
        case 3: 
            return 80
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverViewCell.id, for: indexPath) as? OverViewCell else {
                return UITableViewCell()
            }
            cell.delegate = self
            cell.configureData(movie)
            return cell
        }
        else if indexPath.section == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CastCell.id, for: indexPath) as? CastCell else {
                return UITableViewCell()
            }
            let data = castList[indexPath.row]
            cell.configureData(data)
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.id, for: indexPath) as? MovieCell else { return UITableViewCell()}
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.id)
            cell.collectionView.tag = indexPath.section
            cell.collectionView.reloadData()
            return cell
        }
    }
    
}

extension CreditViewController: OverViewCellDelegate {
    func updateTableView() {
        contentTableView.reloadData()
    }
}

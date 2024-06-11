//
//  SearchViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire

class SearchViewController: UIViewController {
    
    private var searchList: [MovieInfo] = []{
        didSet{
            searchCollectionView.reloadData()
        }
    }
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "게임, 시리즈, 영화를 검색하세요..."
        view.searchTextField.backgroundColor = .systemGray6
        view.searchTextField.textColor = .white
        view.searchBarStyle = .minimal
        return view
    }()
    
    private let searchCollectionView: UICollectionView = {
        let spacing: CGFloat = 4
        let width = UIScreen.main.bounds.width - (2 * spacing)
        let height = UIScreen.main.bounds.height - (3 * spacing)
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: width / 3, height: height / 4)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureHierarchy()
        configureLayout()
        configureCollectionView()
        configureSearchBar()
    }

    private func configureCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
    }
    
    private func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchViewController {
    
    private func callRequest() {
        let url = "https://api.themoviedb.org/3/search/movie"
        let params: Parameters = [
            "query": "게임",
            "language": "ko-KR",
            "page": 1
        ]
        let headers: HTTPHeaders = [
            "Authorization": APIKey.tmdbToken,
            "accept": "application/json"
        ]
        AF.request(url, parameters: params, headers: headers)
            .responseDecodable(of: SearchResult.self) { response in
                switch response.result {
                case .success(let v):
                    self.searchList = v.results
                case .failure(let e):
                    print(e)
                }
            }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.backgroundColor = .blue
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        callRequest()
    }
    
}

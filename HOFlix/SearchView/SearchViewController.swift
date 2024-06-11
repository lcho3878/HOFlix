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
    
    private var page = 1
    
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
        let width = UIScreen.main.bounds.width - (5 * spacing)
        let height = UIScreen.main.bounds.height - (3 * spacing)
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: width / 3, height: height / 4)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
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
        searchCollectionView.prefetchDataSource = self
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
    
    private func callRequest(_ query: String) {
        let url = "https://api.themoviedb.org/3/search/movie"
        let params: Parameters = [
            "query": query,
            "language": "ko-KR",
            "page": page
        ]
        print(#function, page)
        let headers: HTTPHeaders = [
            "Authorization": APIKey.tmdbToken,
            "accept": "application/json"
        ]
        AF.request(url, parameters: params, headers: headers)
            .responseDecodable(of: SearchResult.self) { response in
                switch response.result {
                case .success(let v):
                    if self.page == 1 {
                        self.searchList = v.results
                    }
                    else {
                        self.searchList.append(contentsOf: v.results)
                    }
                    
                case .failure(let e):
                    print(e)
                }
            }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let data = searchList[indexPath.item]
        cell.configureData(data)
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.page = 1
        callRequest(searchBar.searchTextField.text!)
    }
    
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if searchList.count - 2 == item.row {
                page += 1
                callRequest(searchBar.searchTextField.text!)
                print(item.row, page)
            }
        }
    }
    
    
}

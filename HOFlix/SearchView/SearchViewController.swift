//
//  SearchViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire

final class SearchViewController: UIViewController {
    
    private var page = 1
    
    private var searchResult = SearchResult(page: 1, results: [], total_pages: 0, total_results: 0) {
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
        configureUI()
        configureHierarchy()
        configureLayout()
        configureCollectionView()
        configureSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backButtonDisplayMode = .minimal
    }
    
}

extension SearchViewController {
    
    private func callRequest(_ query: String, _ page: Int) {
        TMDBManager.shared.callMovieRequest(api: .search(query: query, page: page), type: SearchResult.self) { result in
            if self.page == 1 {
                self.searchResult = result
                guard !self.searchResult.results.isEmpty else { return }
                self.searchCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            else {
                self.searchResult.results.append(contentsOf: result.results)
            }
        }
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.prefetchDataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        let data = searchResult.results[indexPath.item]
        cell.configureData(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = searchResult.results[indexPath.item]
        let creditVC = CreditViewController()
        creditVC.movie = movie
        navigationController?.pushViewController(creditVC, animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.page = 1
        guard let query = searchBar.searchTextField.text else { return }
        callRequest(query, page)
    }
    
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let query = searchBar.searchTextField.text else { return }
        for item in indexPaths {
            if searchResult.results.count - 2 == item.row && searchResult.total_pages > page {
                page += 1
                callRequest(query, page)
            }
        }
    }
    
    
}

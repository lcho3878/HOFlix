//
//  SearchViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/11/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
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
    }
    
    private func configureCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
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

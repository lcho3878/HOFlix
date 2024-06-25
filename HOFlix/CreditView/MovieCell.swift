//
//  MoiveCell.swift
//  HOFlix
//
//  Created by 이찬호 on 6/25/24.
//

import UIKit
import SnapKit

class MovieCell: UITableViewCell {
    
    let layout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let n: CGFloat = 5
        let spacing: CGFloat = 8
        let width = (UIScreen.main.bounds.width - (n - 1) * spacing) / n
        layout.itemSize = CGSize(width: width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        return layout
    }()
    
     lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    private func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

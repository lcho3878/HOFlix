//
//  SearchCollectionViewCell.swift
//  HOFlix
//
//  Created by 이찬호 on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    
    private let mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureHierarchy() {
        contentView.addSubview(mainImageView)
    }
    
    private func configureLayout() {
        mainImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    func configureData(_ data: MovieInfo) {
        mainImageView.kf.setImage(with: data.posterImageURL)
    }
    
}

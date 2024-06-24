//
//  MovieCollectionViewCell.swift
//  HOFlix
//
//  Created by 이찬호 on 6/24/24.
//

import UIKit
import SnapKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    private let movieImageView = {
        let imgView = UIImageView()
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(movieImageView)
    }
    
    private func configureLayout() {
        movieImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureDate(_ data: MovieInfo) {
        movieImageView.kf.setImage(with: data.posterImageURL)
    }
}

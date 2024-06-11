//
//  CreditTableViewCell.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class CastCell: UITableViewCell {
    
    private let actorImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private let actorNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Lee Jung-jae"
        lb.font = .boldSystemFont(ofSize: 15)
        return lb
    }()
    
    private let actorSubLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Seong Gi-hun / No. 456"
        lb.textColor = .lightGray
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(actorImageView)
        contentView.addSubview(actorNameLabel)
        contentView.addSubview(actorSubLabel)
    }
    
    private func configureLayout() {
        actorImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(actorImageView.snp.height).dividedBy(1.2)
        }
        
        actorNameLabel.snp.makeConstraints {
            $0.leading.equalTo(actorImageView.snp.trailing).offset(8)
            $0.bottom.equalTo(contentView.snp.centerY).inset(4)
        }
        
        actorSubLabel.snp.makeConstraints {
            $0.leading.equalTo(actorNameLabel)
            $0.top.equalTo(contentView.snp.centerY).offset(4)
        }
    }
    
    func configureData(_ data: Cast) {
        actorNameLabel.text = data.name
        actorSubLabel.text = data.character
        actorImageView.kf.setImage(with: data.profileImageURL)
    }
}

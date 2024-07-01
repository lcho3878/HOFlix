//
//  BoxOfficeTableViewCell.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import UIKit
import SnapKit

final class BoxOfficeTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "BoxOfficeTableViewCell"
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .boldSystemFont(ofSize: 20)
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "영화제목목 목목목목ㅁ곰고"
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "2020-12-12"
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
    }
    
    private func configureHierarchy() {
        contentView.addSubview(rankLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
    }
    
    private func configureLayout() {
        rankLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(40)
        }

        dateLabel.snp.makeConstraints {
            $0.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(16)
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            $0.width.equalTo(200)
        }
    }
    
    func configureData(_ data: Movie) {
        rankLabel.text = data.rank
        titleLabel.text = data.movieNm
        dateLabel.text = data.openDt
    }
    
    
    
}

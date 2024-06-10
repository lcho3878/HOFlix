//
//  TrendTableViewCell.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit

class TrendTableViewCell: UITableViewCell {
    
    private let dateLabel: UILabel = {
        let lb = UILabel()
        lb.text = "12/10/2012"
        lb.font = .systemFont(ofSize: 13)
        lb.textColor = .lightGray
        return lb
    }()
    
    private let genreLabel: UILabel = {
        let lb = UILabel()
        lb.text = "#Mystery"
        lb.font = .boldSystemFont(ofSize: 15)
        return lb
    }()
    
    private let movieImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.clipsToBounds = true
        return view
    }()
    
    private let gradeLabel: UIPaddingLabel = {
        let lb = UIPaddingLabel()
        lb.leftInset = 4
        lb.rightInset = 4
        lb.text = "평점"
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 11)
        lb.backgroundColor = .systemTeal
        lb.textAlignment = .center
        return lb
    }()
    
    private let scoreLabel: UIPaddingLabel = {
        let lb = UIPaddingLabel()
        lb.leftInset = 4
        lb.rightInset = 4
        lb.text = "3.3"
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 11)
        lb.backgroundColor = .white
        lb.textAlignment = .center
        return lb
    }()
    
    private let movieContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let movieTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Alice in BorderLand"
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 17)
        return lb
    }()
    
    private let movieCaseLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Kento Yamazaki, Tao Tsuchiya, Nijiro Murakami asdfasdfasdfasdf"
        lb.textColor = .lightGray
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let detailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "자세히 보기"
        lb.font = .boldSystemFont(ofSize: 15)
        return lb
    }()
    
    private let detailImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return view
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
        movieImageView.layer.cornerRadius = 8
    }
    
    private func configureHierarchy() {
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(movieImageView)
        movieImageView.addSubview(movieContentView)
        movieImageView.addSubview(gradeLabel)
        movieImageView.addSubview(scoreLabel)
        movieContentView.addSubview(movieTitleLabel)
        movieContentView.addSubview(movieCaseLabel)
        movieContentView.addSubview(lineView)
        movieContentView.addSubview(detailLabel)
        movieContentView.addSubview(detailImageView)
    }
    
    private func configureLayout() {
        
        dateLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(8)
        }
        
        genreLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalTo(dateLabel)
        }
        
        movieImageView.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.height.equalTo(UIScreen.main.bounds.height / 2.5)
            $0.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
        }
        
        movieContentView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.3)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.height.equalTo(20)
            $0.bottom.equalTo(movieContentView.snp.top).offset(-16)
        }
        
        scoreLabel.snp.makeConstraints {
            $0.leading.equalTo(gradeLabel.snp.trailing)
            $0.height.equalTo(20)
            $0.bottom.equalTo(gradeLabel)
            
        }
        
        movieTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            
        }
        
        movieCaseLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(2)
            $0.leading.equalTo(movieTitleLabel)
            $0.centerX.equalToSuperview()
        }
        
        lineView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(movieCaseLabel)
            $0.top.equalTo(movieCaseLabel.snp.bottom).offset(16)
            $0.height.equalTo(1)
        }
        
        detailLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.equalTo(movieCaseLabel)
        }
        
        detailImageView.snp.makeConstraints {
            $0.size.equalTo(detailLabel.snp.height)
            $0.trailing.equalTo(lineView)
            $0.bottom.equalToSuperview()
        }
        
    }

}

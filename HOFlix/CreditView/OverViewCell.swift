//
//  OverViewCell.swift
//  HOFlix
//
//  Created by 이찬호 on 6/10/24.
//

import UIKit
import SnapKit

protocol OverViewCellDelegate: AnyObject {
    func updateTableView ()
}

class OverViewCell: UITableViewCell {
    weak var delegate: OverViewCellDelegate?
    
    private var isMore = false
    
    private lazy var contentLabel: UILabel = {
        let lb = UILabel()
        lb.text = "어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구어쩌구"
        lb.font = .systemFont(ofSize: 15)
        lb.numberOfLines = 2
        return lb
    }()
    
    private let moreButton: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.down")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        bt.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return bt
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureHierarchy() {
        contentView.addSubview(contentLabel)
        contentView.addSubview(moreButton)
    }
    
    private func configureLayout() {
        contentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.horizontalEdges.equalToSuperview().inset(32)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(8)
        }
    }
    
    @objc
    private func buttonClick() {
        let isMore = contentLabel.numberOfLines == 0
        contentLabel.numberOfLines = isMore ? 2 : 0
        moreButton.setImage(UIImage(systemName: isMore ? "chevron.down" : "chevron.up")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        delegate?.updateTableView()
    }
    
}

//
//  ViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/4/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let mainImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .lightGray
        return view
    }()
    private let playButton: UIButton = {
        let button = UIButton()
        button.setTitle("재생", for: .normal)
        button.setImage(UIImage(systemName: "play.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        return button
    }()
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("내가 찜한 리스트", for: .normal)
        button.setImage(UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        
        button.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        return button
    }()
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 뜨는 콘텐츠"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private let subImageView1: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 8
        
        return view
    }()
    private let subImageView2: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .yellow
        view.layer.cornerRadius = 8
        
        return view
    }()
    private let subImageView3: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    private let subStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureNavigation()
        configureSubviews()
        configureLayout()
    }
    
    private func configureNavigation() {
        navigationItem.title = "lcho3878님"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    private func configureSubviews() {
        view.addSubview(mainImageView)
        view.addSubview(playButton)
        view.addSubview(favoriteButton)
        view.addSubview(subLabel)
        view.addSubview(subStackView)
        subStackView.addArrangedSubview(subImageView1)
        subStackView.addArrangedSubview(subImageView2)
        subStackView.addArrangedSubview(subImageView3)
    }
    
    private func configureLayout() {
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(view.frame.height / 2)
        }
        
        playButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(mainImageView).inset(8)
            $0.width.equalTo(view.frame.width * 0.4)
            $0.height.equalTo(35)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(mainImageView).inset(8)
            $0.size.equalTo(playButton)
        }
        
        subLabel.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(4)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(4)
        }
        
        subStackView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(8)
            $0.top.equalTo(subLabel.snp.bottom).offset(4)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(4)
        }
    }
    
    @objc
    private func playButtonClicked() {
        print(#function)
    }
    
    @objc
    private func favoriteButtonClicked() {
        print(#function)
    }
    


}


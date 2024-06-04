//
//  SignUpViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/4/24.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "HOFlIX"
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var accountTextField = customTextField("이메일 주소 또는 전화번호")
    private lazy var passwordTextField = customTextField("비밀번호")
    private lazy var nicknameTextField = customTextField("닉네임")
    private lazy var locationTextField = customTextField("위치")
    private lazy var codeTextField = customTextField("추천 코드 입력")
    
    private let signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원 가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let extraLabel: UILabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let customSwitch: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.onTintColor = .systemRed
        return sw
    }()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureSubViews()
        configureLayout()
    }
    
    private func configureSubViews() {
        view.addSubview(logoLabel)
        view.addSubview(textFieldStackView)
        textFieldStackView.addArrangedSubview(accountTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        textFieldStackView.addArrangedSubview(nicknameTextField)
        textFieldStackView.addArrangedSubview(locationTextField)
        textFieldStackView.addArrangedSubview(codeTextField)
        view.addSubview(signupButton)
        view.addSubview(extraLabel)
        view.addSubview(customSwitch)
    }
    
    private func configureLayout() {
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        textFieldStackView.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).offset(120)
            $0.horizontalEdges.equalToSuperview().inset(24)
        }
        
        accountTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        signupButton.snp.makeConstraints {
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(16)
            $0.centerX.width.equalTo(textFieldStackView)
            $0.height.equalTo(50)
        }
        
        extraLabel.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(24)
            $0.leading.equalTo(signupButton)
        }
        
        customSwitch.snp.makeConstraints {
            $0.top.equalTo(signupButton.snp.bottom).offset(16)
            $0.trailing.equalTo(signupButton)
        }
        
        
    }
    
    private func customTextField(_ title: String) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.white ])
        textField.textAlignment = .center
        textField.backgroundColor = .lightGray
        textField.layer.cornerRadius = 8
        return textField
    }
    
    @objc
    private func signupButtonClicked() {
        print(#function)
    }
    


}

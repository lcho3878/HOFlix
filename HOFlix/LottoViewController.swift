//
//  LottoViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/4/24.
//

import UIKit

import SnapKit
import Alamofire





class LottoViewController: UIViewController {
    //1122회 이번주 최신 -> 어떻게 최신을 가져올지 몰루
    private let lottoAPI = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
    
    private let lottoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let circle1: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let circle2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let circle3: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let circle4: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let circle5: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let circle6: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let label2: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let label3: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let label4: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let label5: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let label6: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let bonusCircle: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let bonusLabel: UILabel = {
        let label = UILabel()
        label.text = "?"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let roundTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "회차를 입력해주세요"
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        return textField
    }()
    
    private let checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("조회하기", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var circleList = [circle1, circle2, circle3, circle4, circle5, circle6, bonusCircle]
    
    private lazy var labelList = [label1, label2, label3, label4, label5, label6, bonusLabel]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureSubViews()
        configureLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for item in lottoStackView.subviews {
            DispatchQueue.main.async {
                item.layer.cornerRadius = item.frame.width / 2
            }
        }
        bonusCircle.layer.cornerRadius = bonusCircle.frame.width / 2
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "로또 번호 조회하기"
    }
    
    private func configureSubViews() {
        view.addSubview(lottoStackView)
        
        lottoStackView.addArrangedSubview(circle1)
        lottoStackView.addArrangedSubview(circle2)
        lottoStackView.addArrangedSubview(circle3)
        lottoStackView.addArrangedSubview(circle4)
        lottoStackView.addArrangedSubview(circle5)
        lottoStackView.addArrangedSubview(circle6)
        circle1.addSubview(label1)
        circle2.addSubview(label2)
        circle3.addSubview(label3)
        circle4.addSubview(label4)
        circle5.addSubview(label5)
        circle6.addSubview(label6)
        
        view.addSubview(plusImageView)
        
        view.addSubview(bonusCircle)
        bonusCircle.addSubview(bonusLabel)
        
        view.addSubview(contentLabel)
        view.addSubview(roundTextField)
        view.addSubview(checkButton)

    }
    
    private func configureLayout() {
        lottoStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(UIScreen.main.bounds.width / 8)
        }
        
        for circle in circleList {
            circle.snp.makeConstraints {
                $0.size.equalTo(lottoStackView.snp.height)
            }
        }
        
        for label in labelList {
            label.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        plusImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(lottoStackView.snp.bottom).offset(20)
        }
        
        bonusCircle.snp.makeConstraints {
            $0.top.equalTo(plusImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(bonusCircle.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        roundTextField.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(24)
            $0.height.equalTo(40)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(roundTextField.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    @objc
    private func checkButtonClicked() {
        let round = roundTextField.text! == "" ? "1122" : roundTextField.text!
        let url = lottoAPI + round
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                self.updateView(lotto)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateView(_ lotto: Lotto) {
        var list = [
            lotto.drwtNo1,
            lotto.drwtNo2,
            lotto.drwtNo3,
            lotto.drwtNo4,
            lotto.drwtNo5,
            lotto.drwtNo6,
        ].sorted()
        list.append(lotto.bnusNo)
        for i in 0..<labelList.count {
            labelList[i].text = "\(list[i])"
            circleList[i].backgroundColor = colorOfNumber(list[i])
        }
        contentLabel.text = lotto.content
    }
    
    private func colorOfNumber(_ num: Int) -> UIColor {
//      1~10번까지는 노란색, 11~20번은 파란색, 21~30번은 빨간색, 31~40번은 회색, 41~45번은 녹색
        switch num {
        case 1...10:
            return .systemYellow
        case 11...20:
            return .systemBlue
        case 21...30:
            return .systemRed
        case 31...40:
            return .systemGray
        default:
            return .systemGreen
        }
    }
}

struct Lotto: Decodable {
    let drwNoDate: String
    let totSellamnt: Int
    let firstWinamnt: Int
    let firstAccumamnt: Int
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
    let firstPrzwnerCo: Int
    
    var content: String {
        return "1등 당첨금 \(firstWinamnt.formatted())원 (당첨 복권수 \(firstPrzwnerCo)개)"
    }
}


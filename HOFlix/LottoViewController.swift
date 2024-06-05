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
    
    private var recentRound: Int?
    
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
    
    private let pickerView: UIPickerView = {
        let view = UIPickerView()
        return view
    }()
    
    private let roundTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "회차를 입력해주세요"
        textField.backgroundColor = .lightGray
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
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
        getRecentRound()
        configureUI()
        configureSubViews()
        configureLayout()
        configurePickerView()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        roundTextField.endEditing(true)
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
        
        roundTextField.inputView = pickerView
    }
    
    private func configureSubViews() {
        view.addSubview(lottoStackView)
        
        for i in 0..<circleList.count - 1 {
            lottoStackView.addArrangedSubview(circleList[i])
            circleList[i].addSubview(labelList[i])
        }
        
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
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    @objc
    private func checkButtonClicked() {
        guard let recent = recentRound else {
            let alert = UIAlertController(title: "오류", message: "최신 회차 받아오기 실패", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        guard let round = Int(roundTextField.text!), round <= recent else {
            let alert = UIAlertController(title: "오류", message: "\(recent) 이하의 숫자만 입력가능합니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            return
        }
        
        let url = lottoAPI + String(round)
        AF.request(url).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                self.updateView(lotto)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func getRecentRound() {
        let url = "https://dhlottery.co.kr/common.do?method=main"
        AF.request(url).responseString { response in
            switch response.result {
            case .success(let value):
                if let range1 = value.range(of: "id=\"lottoDrwNo\">", options: [.caseInsensitive]  ),
                   let range2 = value.range(of: "</strong>È¸ <span class=\"txt\">´çÃ·°á°ú</span> ", options: [.caseInsensitive]) {
                    let recent = value[range1.upperBound..<range2.lowerBound]
                    guard let recent = Int(recent) else { return }
                    self.recentRound = recent
                    self.roundTextField.text = String(recent)
                    self.checkButtonClicked()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func updateView(_ lotto: Lotto) {
        for i in 0..<labelList.count {
            labelList[i].text = "\(lotto.drwtNoList[i])"
            circleList[i].backgroundColor = colorOfNumber(lotto.drwtNoList[i])
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

extension LottoViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let recentRound else { return 1 }
        return recentRound
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let recentRound else { return "서버 오류"}
        return "\(recentRound - row) 회차"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let recentRound else { return }
        roundTextField.text = String(recentRound - row)
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
    
    var drwtNoList: [Int] {
        var list = [
            drwtNo1,
            drwtNo2,
            drwtNo3,
            drwtNo4,
            drwtNo5,
            drwtNo6,
        ].sorted()
        list.append(bnusNo)
        return list
    }
    
    var content: String {
        return "1등 당첨금 \(firstWinamnt.formatted())원 (당첨 복권수 \(firstPrzwnerCo)개)"
    }
}


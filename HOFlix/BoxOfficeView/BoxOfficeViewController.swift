//
//  BoxOfficeViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import UIKit
import SnapKit
import Alamofire

class BoxOfficeViewController: UIViewController {
    
    private var yesterday: Date {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!
        return yesterday
    }
    
    private var movieList: [Movie] = [] {
        didSet{
            boxTableView.reloadData()
        }
    }

    private let searchTextField: UITextField = {
        let view = UITextField()
        view.textColor = .white
        view.placeholder = "날짜를 입력해주세요"
        return view
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private let boxTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.rowHeight = 50
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBoxOffice()
        configreHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchTextField.underlined(2, .white)
    }
    
    private func configreHierarchy() {
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(boxTableView)
    }
    
    private func configureLayout() {
        searchButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.width.equalTo(80)
            $0.height.equalTo(40)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.trailing.equalTo(searchButton).inset(90)
            $0.height.equalTo(searchButton)
        }
        
        boxTableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .black
    }
    
    private func configureTableView() {
        boxTableView.delegate = self
        boxTableView.dataSource = self
        boxTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: BoxOfficeTableViewCell.reuseIdentifier)
    }

    private func getBoxOffice() {
        let api = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
        let key = APIKey.movieAPIKey
        let date = yesterday.string("yyyyMMdd")
        let url = api + "key=" + key + "&targetDt=" + date
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let value):
                self.movieList = value.boxOfficeResult.dailyBoxOfficeList
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    private func searchButtonClicked() {
        getBoxOffice()
    }
}

extension BoxOfficeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.reuseIdentifier, for: indexPath) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        let data = movieList[indexPath.row]
        cell.configureData(data)
        return cell
    }
}




//
//  WeatherViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import UIKit
import Alamofire
import CoreLocation
import SnapKit

class WeatherViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    
    private let indicator = {
        let indi = UIActivityIndicatorView()
        indi.style = .large
        indi.color = .white
        return indi
    }()
    
    private let cityLabel = {
        let lb = UILabel()
        lb.textColor = .white
//        lb.text = "도시 이름"
        return lb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configurelocationManager()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemOrange
    }
    
    private func configureHierarchy() {
        view.addSubview(cityLabel)
        view.addSubview(indicator)
    }
    
    private func configureLayout() {
        cityLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        indicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

extension WeatherViewController {
    
    private func checkDeiveLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
        }
        else {
            print("위치 서비스 꺼져있음")
        }
    }
    
    private func checkCurrentLocationAuthorization() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("거부")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            indicator.startAnimating()
        default:
            print(status)
        }
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    private func configurelocationManager() {
        locationManager.delegate = self
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lat = manager.location?.coordinate.latitude,
              let lon = manager.location?.coordinate.longitude else { return }
        locationManager.stopUpdatingLocation()
        callRequest(lat: lat, lon: lon)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        print(#function)
        checkDeiveLocationAuthorization()
    }
}

extension WeatherViewController {
    private func callRequest(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let params: Parameters = [
            "lat": String(lat),
            "lon": String(lon),
            "appid": APIKey.weatherAPIKey,
            "units": "metric",
            "lang": "kr"
        ]
        AF.request(url, parameters: params)
            .responseDecodable(of: WeatherResult.self) { response in
            switch response.result {
            case .success(let v):
                print(v.weather)
                self.cityLabel.text = v.name
                self.indicator.stopAnimating()
            case .failure(let e):
                print(e)
            }
        }
    }
}

struct WeatherResult: Decodable {
    let weather: [Weather]
    let main: [String: Double]
    let wind: [String: Double]
    let name: String
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

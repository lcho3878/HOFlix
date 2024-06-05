//
//  WeatherViewController.swift
//  HOFlix
//
//  Created by 이찬호 on 6/5/24.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()

    }
    


}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lat = manager.location?.coordinate.latitude
        let lon = manager.location?.coordinate.longitude
        let city = "Seoul"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(APIKey.weatherAPIKey)&lang=kr&units=metric"
        
        AF.request(url).responseDecodable(of: WeatherResult.self){ response in
            switch response.result {
            case .success(let v):
                print(v)
            case .failure(let e):
                print("error: ", e)
            }
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("error")
    }
}

struct WeatherResult: Decodable {
    let weather: [Weather]
    let main: [String: Double]
    let wind: [String: Double]
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

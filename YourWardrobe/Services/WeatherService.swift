//
//  WeatherService.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/27/25.
//

//import Foundation
//
//class WeatherService {
//    private let apiKey = ""
//    private let baseURL = "http://api.openweathermap.org/data/2.5/weather"
//    
//    func fetchWeather(for city: String, completion: @escaping (WeatherResponse?) -> Void) {
//        let query = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let urlString = "\(baseURL)?q=\(query)&units=metric&appid=\(apiKey)&units=metric"
//        guard let url = URL(string: urlString) else {
//            completion(nil)
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//            do {
//                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
//                completion(weatherResponse)
//            } catch {
//                "Parsing Error"
//                completion(nil)
//            }
//        }.resume()
//        
//    }
//}

//
//  WheaterModels.swift
//  YourWardrobe
//
//  Created by Anna Zhmurkova on 3/22/25.
//

struct WeatherModel {
    let main: Main
    let weather: [Weather]
    
    struct Main {
        let temp: Double
    }
    
    struct Weather {
        let icon: String
        let description: String
    }
}

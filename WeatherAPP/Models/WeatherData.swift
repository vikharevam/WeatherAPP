//
//  WeatherData.swift
//  WeatherAPP
//
//  Created by Александр Вихарев on 04.05.2023.
//

import Foundation


struct WeatherData: Decodable {
    let name: String
    let main: Main
}

struct Main: Decodable {
    let temp: Double
    
}

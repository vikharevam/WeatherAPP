//
//  ManagerWeather.swift
//  WeatherAPP
//
//  Created by Александр Вихарев on 02.05.2023.
//

import Foundation


struct ManagerWeather {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=9a9121b76931d85994cc0c263f8b081a"
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
     
        if let url = URL(string: urlString) {
       
            let session = URLSession(configuration: .default)
       
            let task = session.dataTask(with: url) { data, responce, error in
                if error != nil{
                    print(error!)
                    return
                }
                if let safeData = data {
                    parseJSON(weatherData: safeData)
                }
            }
           
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decoderData.main.temp)
        } catch {
            print(error)
        }
    }
    
    
}


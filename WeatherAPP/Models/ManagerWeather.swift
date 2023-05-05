//
//  ManagerWeather.swift
//  WeatherAPP
//
//  Created by Александр Вихарев on 02.05.2023.
//

import Foundation

protocol ManagerWeatherDelegate {
    func didUpdateWeather(_ managerWeather: ManagerWeather, weather: WeatherModel)
    
    func didFailWithError(error: Error)
    
}



struct ManagerWeather {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=9a9121b76931d85994cc0c263f8b081a&units=metric"
    
    
    var delegate: ManagerWeatherDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
     
        if let url = URL(string: urlString) {
       
            let session = URLSession(configuration: .default)
       
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                   if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decoderData.weather[0].id
            let temp = decoderData.main.temp
            let name = decoderData.name
            
            let weather = WeatherModel(condition: id, cityName: name, temperature: temp)
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
   
    
}



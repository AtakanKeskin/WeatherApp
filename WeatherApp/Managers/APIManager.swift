//
//  APIManager.swift
//  WeatherApp
//
//  Created by macbook on 8.12.2021.
//

import UIKit
import CoreLocation

final class APIManager {
    
    static let shared = APIManager()
    
    struct Constants {
        static let weatherBaseURL = "https://api.openweathermap.org/data/2.5/onecall?"
        static let exclude = "&exclude=mintuely"
        static let units = "&units=metric"
    }
    
    enum HTTPMethod : String{
        case GET
        case POST
    }
    
    enum APIError : Error{
        case failedToGetData
    }
    
    private init() {}
    
    private func createRequest(with url: URL?,type : HTTPMethod,completion: @escaping (URLRequest) -> Void){
        
        guard let apiUrl = url else{
            return
        }
        var request = URLRequest(url: apiUrl)
        request.httpMethod = type.rawValue
        completion(request)
    }
    
    
    
    public func getWeatherForecast(lat : String, lon : String, completion : (@escaping (Result<ForecastModel,Error>) -> Void)) {
        let urlStr = URL(string: "\(Constants.weatherBaseURL)lat=\(lat)&lon=\(lon)\(Constants.exclude)\(Constants.units)\(Secrets.apiKey)")
        createRequest(with: urlStr, type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                guard let data = data, error == nil else {
                    completion(.failure(APIError.failedToGetData))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ForecastModel.self, from: data)
                   
                    completion(.success(result))
                
                }catch {
                    completion(.failure(error))
                }
                
            }
            task.resume()
        }
    }
    
}

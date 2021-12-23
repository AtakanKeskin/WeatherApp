//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by macbook on 8.12.2021.
//

import UIKit


import Foundation

struct ForecastModel: Codable {
    let lat, lon: Double
    let current: Current
    let hourly: [Current]
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon
        case current, hourly, daily
    }
}

struct Current: Codable {
    let dt: Int
    let temp: Double
    let weather: [Weather]


    enum CodingKeys: String, CodingKey {
        case dt,temp
        case weather
    }
}

struct Weather: Codable {
    let id: Int
    let main: Main
    let weatherDescription: Description
    let icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case thunderStorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case snow = "Snow"
    case mist = "Mist"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case mist = "mist"
    case rain = "rain"
    case moderateRain = "moderate rain"
    case heavyIntensityRain = "heavy intensity rain"
    case lightSnow = "light snow"
}


struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case weather    }
}


struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
}

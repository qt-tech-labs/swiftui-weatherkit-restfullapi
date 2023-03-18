//
//  Weather.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/16/23.
//

import Foundation
// To parse the JSON, add this file to your project and do:
//
//   let hourlyWeather = try? JSONDecoder().decode(HourlyWeather.self, from: jsonData)

// MARK: - HourlyWeather
struct HourlyWeather: Codable {
    let forecastHourly: ForecastHourly
}

// MARK: - ForecastHourly
struct ForecastHourly: Codable {
    let name: String
    let metadata: Metadata
    let hours: [Hour]
}

// MARK: - Hour
struct Hour: Codable {
    let forecastStart: Date
    let cloudCover, cloudCoverLowAltPct, cloudCoverMidAltPct, cloudCoverHighAltPct: Double
    let conditionCode: ConditionCode
    let daylight: Bool
    let humidity, precipitationAmount, precipitationIntensity, precipitationChance: Double
    let precipitationType: PrecipitationType
    let pressure: Double
    let pressureTrend: PressureTrend
    let snowfallIntensity, snowfallAmount: Int
    let temperature, temperatureApparent, temperatureDewPoint: Double
    let uvIndex: Int
    let visibility: Double
    let windDirection: Int
    let windGust, windSpeed: Double
}

enum ConditionCode: String, Codable {
    case cloudy = "Cloudy"
    case drizzle = "Drizzle"
    case mostlyCloudy = "MostlyCloudy"
    case mostlyClear = "MostlyClear"
    case windy = "Windy"
    case rain = "Rain"
    case partlyCloudy = "PartlyCloudy"
    case thunderstorms = "Thunderstorms"
    case clear = "Clear"
}

enum PrecipitationType: String, Codable {
    case clear = "clear"
    case rain = "rain"
}

enum PressureTrend: String, Codable {
    case falling = "falling"
    case rising = "rising"
    case steady = "steady"
}

// MARK: - Metadata
struct Metadata: Codable {
    let attributionURL: String
    let expireTime: Date
    let latitude, longitude: Double
    let readTime: Date
    let reportedTime: Date
    let units: String
    let version: Int
}

//
//  DailyWeather.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/16/23.
//
// To parse the JSON, add this file to your project and do:
//
//   let dailyWeather = try? JSONDecoder().decode(DailyWeather.self, from: jsonData)

import Foundation

// MARK: - DailyWeather
struct DailyWeather: Codable {
    let forecastDaily: ForecastDaily
}

// MARK: - ForecastDaily
struct ForecastDaily: Codable {
    let name: String
//    let metadata: Metadata
    let days: [Day]
}

// MARK: - Day
struct Day: Codable {
    let forecastStart, forecastEnd: Date
    let conditionCode: ConditionCode
    let maxUvIndex: Int
    let moonPhase: String
    let moonrise: Date?
    let moonset: Date?
    let precipitationAmount, precipitationChance: Double
    let precipitationType: PrecipitationType
    let snowfallAmount: Int
    let solarMidnight, solarNoon, sunrise, sunriseCivil: Date
    let sunriseNautical, sunriseAstronomical, sunset, sunsetCivil: Date
    let sunsetNautical, sunsetAstronomical: Date
    let temperatureMax, temperatureMin: Double
    let daytimeForecast, overnightForecast: Forecast
    let restOfDayForecast: Forecast?
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastStart, forecastEnd: Date
    let cloudCover: Double
    let conditionCode: String
    let humidity, precipitationAmount, precipitationChance: Double
    let precipitationType: PrecipitationType
    let snowfallAmount, windDirection: Int
    let windSpeed: Double
}

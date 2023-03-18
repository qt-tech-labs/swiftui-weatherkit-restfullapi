//
//  HourlyWeather+Extension.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/17/23.
//

import Foundation

extension ConditionCode {
    var icon: String {
        switch self {
        case .cloudy:
            return "cloud.fill"
        case .partlyCloudy:
            return "cloud.sun.fill"
        case .mostlyCloudy:
            return "cloud.fog.fill"
        case .drizzle:
            return "cloud.drizzle.fill"
        case .clear:
            return "sun.min.fill"
        case .mostlyClear:
            return "sun.max.fill"
        case .thunderstorms:
            return "bolt.horizontal.icloud.fill"
        default:
            return "sun.min"
        }
    }
}
extension Day {
    var temperatureMaxString: String {
        return temperatureMax.toString()
    }
    var temperatureMinString: String {
        return temperatureMax.toString()
    }
    var weekDays: String {
        let isToday = Calendar.current.compare(Date(), to: forecastEnd, toGranularity: .day)
        switch isToday {
        case .orderedSame:
            return "Today"
        default:
            return forecastEnd.toShortWeekday()
        }
    }
}
extension Hour {
    var hourString: String {
        return forecastStart.toHour()
    }
}

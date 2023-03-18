//
//  APIProtocol.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/17/23.
//

import Foundation
import CoreLocation

protocol ApiProtocol {
    func fetchDaily(completion: @escaping(Result<[Day], APIError>) -> Void)
    func fetchHourly(date: Date, completion: @escaping(Result<[Hour], APIError>) -> Void)
}

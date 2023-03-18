//
//  APIProtocol.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/17/23.
//

import Foundation
import CoreLocation

protocol ApiProtocol {
    func fetchDaily(location: CLLocationCoordinate2D, completion: @escaping(Result<[Day], APIError>) -> Void)
    func fetchHourly(location: CLLocationCoordinate2D, date: Date, completion: @escaping(Result<[Hour], APIError>) -> Void)
}

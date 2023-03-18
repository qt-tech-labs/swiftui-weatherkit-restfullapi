//
//  APIService.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/17/23.
//

import Foundation
import CoreLocation
struct APIService: ApiProtocol {
    func buildBaseURL(_ location: CLLocationCoordinate2D, _ dataset: String) -> String {
        return "https://weatherkit.apple.com/api/v1/weather/en_US/\(location.latitude)/\(location.longitude)?dataSets=\(dataset)"
    }
    
    func fetchDaily(location: CLLocationCoordinate2D, completion: @escaping (Result<[Day], APIError>) -> Void) {
        let url = buildBaseURL(location, "forecastDaily")
        fetch(DailyWeather.self, url: url) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data.forecastDaily.days))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchHourly(location: CLLocationCoordinate2D, date: Date, completion: @escaping (Result<[Hour], APIError>) -> Void) {
        let dateComponent = date.toString("yyyy-MM-dd")
        let url = buildBaseURL(location, "forecastHourly") + "&hourlyStart=\(dateComponent)T00:00:00Z&hourlyEnd=\(dateComponent)T23:59:59Z"
        fetch(HourlyWeather.self, url: url) { (result) in
            switch result {
            case .success(let data):
                completion(.success(data.forecastHourly.hours))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, url: String, completion: @escaping(Result<T,APIError>) -> Void) {
        guard let url = URL(string: url) else {
                let error = APIError.badURL
                completion(Result.failure(error))
                return
            }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJFUzI1NiIsImtpZCI6IkZENFRaNTk1V0EiLCJpZCI6IkFXUjIyNDc5TTQuY29tLmh5ZWwuaW9zLndlYXRoZXIiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE2Nzg5NTE1NTksImV4cCI6MTY4OTEzNDY0NiwiaXNzIjoiQVdSMjI0NzlNNCIsInN1YiI6ImNvbS5oeWVsLmlvcy53ZWF0aGVyIn0.1DJn1h9SAh4V_-e74epRRINhEbDdYeq8SUnjP7RtzhXMMmOGOxwIwQOEjSeB5Qv5mpVyteY5bif5ijAQWcZ9TA", forHTTPHeaderField: "Authorization")
            let task = URLSession.shared.dataTask(with: request) {(data , response, error) in
                print("got response")
                if let error = error as? URLError {
                    completion(Result.failure(APIError.url(error)))
                }else if  let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                    completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
                }else if let data = data {
                    let decoder = JSONDecoder()
                    // Custom date formater
                    let dateFormater = DateFormatter()
                    dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    decoder.dateDecodingStrategy = .formatted(dateFormater)
                    do {
                        let result = try decoder.decode(type, from: data)
                        completion(Result.success(result))
                        
                    }catch {
                        completion(Result.failure(APIError.parsing(error as? DecodingError)))
                    }

                }
            }

            task.resume()
        }
    
//    func fetchCombine() {
//        let decoder = JSONDecoder()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
//        decoder.dateDecodingStrategy = .formatted(dateFormatter)
//        
//        guard let url = URL(string: "https://weatherkit.apple.com/api/v1/weather/en_US/34.052/118.24?dataSets=forecastDaily&country=US") else { return }
//        
//        var request = URLRequest(url: url)
//        request.setValue("Bearer eyJhbGciOiJFUzI1NiIsImtpZCI6IkZENFRaNTk1V0EiLCJpZCI6IkFXUjIyNDc5TTQuY29tLmh5ZWwuaW9zLndlYXRoZXIiLCJ0eXAiOiJKV1QifQ.eyJpYXQiOjE2Nzg5NTE1NTksImV4cCI6MTY4OTEzNDY0NiwiaXNzIjoiQVdSMjI0NzlNNCIsInN1YiI6ImNvbS5oeWVsLmlvcy53ZWF0aGVyIn0.1DJn1h9SAh4V_-e74epRRINhEbDdYeq8SUnjP7RtzhXMMmOGOxwIwQOEjSeB5Qv5mpVyteY5bif5ijAQWcZ9TA", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTaskPublisher(for: request)//1
//            .subscribe(on: DispatchQueue.global(qos: .background)) //2
//            .receive(on: DispatchQueue.main) //3
//            .tryMap { (data, response) -> Data in //4
//                let str = String(decoding: data, as: UTF8.self)
//                print(str)
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
//            .decode(type: DailyWeather?.self, decoder: decoder) //5
//            .mapError({ (error) -> Error in
//                print(error)
//                return error
//            })
//            .sink { (completion) in //7
//                print("completion: \(completion)")
//            } receiveValue: { [weak self] (response) in
//                self?.days = response?.forecastDaily.days ?? []
//            }
//            .store(in: &cancellables) //8
//    }
}

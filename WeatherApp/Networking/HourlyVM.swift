//
//  HourlyVM.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/18/23.
//

import Foundation

class HourlyVM: ObservableObject {
    @Published var hours = [Hour]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: ApiProtocol
    
    init(service: ApiProtocol = APIService()) {
        self.service = service
    }
    
    func loadHourlyData(date: Date) {
        isLoading = true
        errorMessage = nil
        service.fetchHourly(date: date, completion: { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let hours):
                    print("--- sucess with \(hours.count)")
                    self.hours = hours
                }
            }
        })
    }
}

//
//  HourlyView.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/17/23.
//

import SwiftUI

struct HourlyView: View {
    @Binding var selectedDate: Date
    @State var loaded = false
    @StateObject var fetcher = HourlyVM()
    @ObservedObject var locationManager: LocationManager
    var body: some View {
        ZStack {
            Color.ui.secondary
                .ignoresSafeArea()
            if fetcher.isLoading {
                Text("Loading data...")
                ProgressView()
            } else if fetcher.errorMessage != nil {
                Text("Fail to load data! Error: \(fetcher.errorMessage ?? "NA")")
                Button("Reload") {
                    if let location = locationManager.locationManager.location?.coordinate {
                        fetcher.loadHourlyData(location: location, date: self.selectedDate)
                    }
                }
            } else {
                VStack(alignment: .leading) {
                    List {
                        ForEach(fetcher.hours, id: \.forecastStart) { hour in
                            HStack {
                                Text(hour.hourString)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.white)
                                Image(systemName: hour.conditionCode.icon).frame(maxWidth: .infinity).foregroundColor(.white)
                                HStack(alignment: .top, spacing: 1) {
                                    Text(hour.temperature.toString()).foregroundColor(.gray)
                                    Image(systemName: "circle")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 6, weight: .bold))
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .listRowBackground(Color.ui.secondary)
                    }
                    .onAppear(perform: {
                        UITableView.appearance().backgroundColor = .clear
                    })
                    .background(Color.ui.secondary)
                }
                .background(Color.ui.secondary)
                .onAppear {
                    if !loaded, let location = locationManager.locationManager.location?.coordinate {
                        loaded = true
                        fetcher.loadHourlyData(location: location, date: self.selectedDate)
                    }
                    
                }
            }
        }
    }
}

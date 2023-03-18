//
//  ContentView.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    @StateObject var fetcher = DailyVM()
    @StateObject var locationManager = LocationManager()
    @State var selectedDate  = Date()
    var body: some View {
        ZStack {
            Color.ui.primary
                .ignoresSafeArea()
            switch locationManager.locationManager.authorizationStatus {
            case .authorizedWhenInUse:
                if fetcher.isLoading {
                    Text("Loading data...")
                    ProgressView()
                } else if fetcher.errorMessage != nil {
                    Text("Fail to load data! Error: \(fetcher.errorMessage ?? "NA")")
                    Button("Reload") {
                        fetcher.loadDailyData()
                    }
                } else {
                    VStack(alignment: .leading) {
                        Text("10-day forecast")
                            .foregroundColor(Color(hex: "777795"))
                            .textCase(.uppercase)
                            .padding(.vertical, 10)
                        List {
                            ForEach (fetcher.days, id: \.forecastStart) { day in
                                ForecastRow(day: day) {
                                    showingSheet.toggle()
                                    self.selectedDate = day.forecastStart
                                }
                            }//Foreach
                            .listRowBackground(Color.ui.secondary)
                        }//List
                        .onAppear(perform: {
                            UITableView.appearance().backgroundColor = .clear
                        })
                        .background(Color.ui.secondary)
                        .sheet(isPresented: $showingSheet, content: {
                            NavigationView {
                                HourlyView(selectedDate: self.$selectedDate, showingModal: self.$showingSheet)
                                    
                                    .navigationTitle(selectedDate.toString())
                                        .navigationBarItems(trailing: Button("Done",
                                                                             action: {self.showingSheet.toggle()}))
                                    }
                        })
                    }// VStack
                    .cornerRadius(15)
                    .background(Color.ui.secondary)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                }
            case .restricted, .denied:  // Location services currently unavailable.
                Text("Current location data was restricted or denied.")
            case .notDetermined:        // Authorization not determined yet.
                Text("Finding your location...")
                ProgressView()
            default:
                ProgressView()
            }
        }//ZStack
    }//Body
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

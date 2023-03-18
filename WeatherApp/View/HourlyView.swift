//
//  HourlyView.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/17/23.
//

import SwiftUI

struct HourlyView: View {
    @Binding var selectedDate: Date
    @Binding var showingModal: Bool
    @StateObject var fetcher = HourlyVM()
    var body: some View {
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
            fetcher.loadHourlyData(date: self.selectedDate)
        }
    }
}

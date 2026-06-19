//
//  CityDetailView.swift
//  WheatherDashboard
//
//  Created by Pradeep Kumar Sagar on 19/06/26.
//

import SwiftUI

struct CityDetailView: View {
    let data: WheatherInfo

    var body: some View {
        VStack(spacing: 16) {
            Text(data.cityName)
                .font(.largeTitle)
                .bold()
            Text("\(data.temp)°")
                .font(.system(size: 64, weight: .semibold))
            Text(data.description)
                .font(.title3)
            Text(data.hl)
                .font(.headline)
            Text("Updated at \(data.time)")
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle(data.cityName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CityDetailView(data: WheatherInfo(id: 1, cityName: "Kolkata", temp: "40", description: "Heavy rain", icon: "rain", time: "8:05 PM", hl: "H: 34° | L: 26°"))
}

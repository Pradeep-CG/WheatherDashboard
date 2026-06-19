//
//  FirstView.swift
//  WheatherDashboard
//
//  Created by Pradeep Kumar Sagar on 10/06/26.
//

import SwiftUI

struct WheatherInfo: Identifiable {
    var id: Int
    var cityName: String
    var temp: String
    var description: String
    var icon: String
    var time: String
    var hl: String
}
struct FirstView: View {
    var whetherData = [
        WheatherInfo(id: 1, cityName: "Giridih", temp: "30", description: "Mostly Clear", icon: "clear", time: "08:05 PM", hl: "H:36°  L:28°"),
        WheatherInfo(id: 2, cityName: "Bangaluru", temp: "25", description: "Isolated Thunderstorms", icon: "thundar", time: "08:05 PM", hl: "H:26°  L:20°"),
        WheatherInfo(id: 3, cityName: "New Delhi", temp: "32", description: "Mostly Cloud", icon: "mostlyCloud", time: "08:05 PM", hl: "H:33°  L:25°"),
        WheatherInfo(id: 4, cityName: "Mumbai", temp: "33", description: "Cloud", icon: "cloud", time: "08:05 PM", hl: "H:34°  L:22°"),
        WheatherInfo(id: 5, cityName: "Chennai", temp: "22", description: "Raining", icon: "rain", time: "08:05 PM", hl: "H:24°  L:18°"),
        WheatherInfo(id: 6, cityName: "Hyderabad", temp: "30", description: "Mostly Clear", icon: "clear", time: "08:05 PM", hl: "H:36°  L:28°"),
        WheatherInfo(id: 7, cityName: "Bhopal", temp: "12", description: "Mostly Cloudy", icon: "mostlyCloudy", time: "08:05 PM", hl: "H:14°  L:07°"),
        WheatherInfo(id: 8, cityName: "Kolkata", temp: "25", description: "Isolated Thunderstorms", icon: "thundar", time: "08:05 PM", hl: "H:26°  L:20°"),
        WheatherInfo(id: 9, cityName: "Keral", temp: "21", description: "Raining", icon: "rain", time: "08:05 PM", hl: "H:24°  L:18°"),
    ]
    init() {

            let appearance = UINavigationBarAppearance()

            // Inline title color

            appearance.titleTextAttributes = [

                .foregroundColor: UIColor.white

            ]

            // Large title color

            appearance.largeTitleTextAttributes = [

                .foregroundColor: UIColor.white

            ]

            UINavigationBar.appearance().standardAppearance = appearance

            UINavigationBar.appearance().scrollEdgeAppearance = appearance

        }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.black)
                    .opacity(0.8)
                    .ignoresSafeArea()
                
                VStack(spacing: 30){
                    titleView
                    ScrollView(.vertical){
                        

                        VStack(spacing: 100){
                            ForEach(whetherData, id: \.id){ data in
                                NavigationLink {
                                    CityDetailView(data: data)
                                } label: {
                                    CityView(data: data)
                                }

                            }
                        }
                        .padding(.top, 40)
                        .padding(.bottom, 20)
                    }
                 }
            }
        }
    }
    
    var titleView: some View {
        HStack {
            HStack{
                Text("Whether")
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                    .bold()
                
                Image(systemName: "cloud.sun.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(Color.white)
            }
            Spacer()
            
           Image(systemName: "ellipsis.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.white)

            
            //"ellipsis.circle"
        }
        
    }

}
struct CityView: View {
    var data: WheatherInfo
    
    var body: some View {
        ZStack {
            // Background image
            Image(data.icon) // replace with your starry/night asset if different
                .resizable()
                .scaledToFill()
                .frame(height: 100)
                //.clipped()

            // A subtle top-to-bottom gradient to improve text contrast
            LinearGradient(
                colors: [
                    Color.black.opacity(0.25),
                    Color.black.opacity(0.35)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .allowsHitTesting(false)

            // Foreground content
            VStack(alignment: .leading, spacing: 6) {
                HStack(alignment: .top) {
                    // Left: City title
                    Text(data.cityName)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    // Right: Temperature
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text(data.temp)
                            .font(.system(size: 48, weight: .semibold))
                            .foregroundStyle(.white)
                        Text("°")
                            .font(.system(size: 36, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }

                // My Location • Home row
                HStack(spacing: 8) {
                    Text(data.time)
//                    Image(systemName: "house.fill")
//                    Text("Home")
                }
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white.opacity(0.8))
                .offset(x: 0, y: -25)
                Spacer(minLength: 0)

                // Bottom row: Mostly Clear on left, High/Low on right
                HStack {
                    Text(data.description)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.85))

                    Spacer()

                    Text(data.hl)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.85))
                }
                .padding(.top, 4)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(.white.opacity(0.2), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.25), radius: 12, x: 0, y: 8)
        .padding(.horizontal) // optional: outer padding relative to the screen edges
        .frame(height: 60)

    }
}


#Preview {
    FirstView()
}

//
//  CityDetailView.swift
//  WheatherDashboard
//
//  Created by Pradeep Kumar Sagar on 19/06/26.
//

import SwiftUI

private struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct CityDetailView: View {
    let data: WheatherInfo
    @State private var isScrollUp: Bool = false
    @State private var isAtTop = true
    @State private var lastOffset: CGFloat = 0
    @Environment(\.dismiss) private var dismiss
    
    var timeData = [
        TimeData(id: 1, time: "05:54 AM", icon: "sunrise", temp: "10°C"),
        TimeData(id: 2, time: "6 AM", icon: "cloud.fill", temp: "11°C"),
        TimeData(id: 3, time: "7 AM", icon: "cloud.fill", temp: "12°C"),
        TimeData(id: 4, time: "8 AM", icon: "cloud.drizzle.fill", temp: "11°C"),
        TimeData(id: 5, time: "9 AM", icon: "cloud.fill", temp: "12°C"),
        TimeData(id: 6, time: "10 AM", icon: "cloud.fill", temp: "13°C"),
        TimeData(id: 7, time: "11 AM", icon: "cloud.drizzle.fill", temp: "10°C"),
        TimeData(id: 8, time: "12 PM", icon: "cloud.fill", temp: "15°C"),
        TimeData(id: 9, time: "1 PM", icon: "cloud.fill", temp: "12°C"),
        TimeData(id: 10, time: "2 PM", icon: "cloud.drizzle.fill", temp: "8°C"),
    ]
    var dayForeCast = [
        DayForecast(id: 1, day: "Today", icon: "cloud.fill", tempMin: "10°C", tempMax: "15°C", rainPercent: 0, progess: 20),
        DayForecast(id: 2, day: "Sat", icon: "cloud.fill", tempMin: "13°C", tempMax: "17°C", rainPercent: 0, progess: 60),
        DayForecast(id: 3, day: "Sun", icon: "cloud.drizzle.fill", tempMin: "18°C", tempMax: "32°C", rainPercent: 20, progess: 70),
        DayForecast(id: 4, day: "Mon", icon: "cloud.drizzle.fill", tempMin: "7°C", tempMax: "15°C", rainPercent: 50, progess: 42),
        DayForecast(id: 5, day: "Tue", icon: "cloud.fill", tempMin: "10°C", tempMax: "15°C", rainPercent: 0, progess: 45),
        DayForecast(id: 6, day: "Wed", icon: "cloud.fill", tempMin: "10°C", tempMax: "15°C", rainPercent: 0, progess: 88),
        DayForecast(id: 7, day: "Thu", icon: "cloud.fill", tempMin: "10°C", tempMax: "15°C", rainPercent: 0, progess: 10),
        DayForecast(id: 8, day: "Fri", icon: "cloud.drizzle.fill", tempMin: "10°C", tempMax: "15°C", rainPercent: 60, progess: 90),
        DayForecast(id: 9, day: "Sat", icon: "cloud.fill", tempMin: "10°C", tempMax: "15°C", rainPercent: 0, progess: 30),
        DayForecast(id: 10, day: "Sun", icon: "cloud.fill", tempMin: "10°C", tempMax: "15°C", rainPercent: 0, progess: 70),
    ]
    var body: some View {
        
        backgroundView
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        .onAppear{
            print("isscrollup:", isScrollUp)
        }
       // .ignoresSafeArea(.all)
    }
    var backgroundView: some View {
        VStack{
            if !isScrollUp {
                verticalDetail
            }
            else{
                horizontalDetail
            }
                
            List {
                timeAndTempView
                    .listRowBackground(Color.black.opacity(0.5))
               tenDayForecast
                    .listRowBackground(Color.black.opacity(0.5))
                
                feelLikeView
                    .listRowBackground(Color.black.opacity(0.5))
            }
            //.listStyle(.insetGrouped)
            .scrollContentBackground(.hidden)
            .onScrollGeometryChange(for: CGFloat.self) { geometry in
                // Track vertical content offset
                geometry.contentOffset.y
            } action: { oldOffset, newOffset in
                // Direction: if new < old, user scrolled up (toward top)
                //isScrollUp = newOffset < oldOffset

                if newOffset < oldOffset {
                    isScrollUp = false
                }
                if newOffset > oldOffset {
                    isScrollUp = true
                }
                // At top when offset is very close to 0
                // Add a small tolerance to account for bounce/precision
                let tolerance: CGFloat = 1
                isAtTop = newOffset <= tolerance

            
                if isAtTop {
                    isScrollUp = false
                }
                else{
                    isScrollUp = true
                }
                // Debug if needed
                 print("offset:", newOffset, "isScrollingUp:", isScrollUp, "isAtTop:", isAtTop)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: isScrollUp)
        .background(content: {
            Image(data.icon)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay {
                    LinearGradient(
                        colors: [.clear, .gray.opacity(0.6), Color("detailBG").opacity(0.8), Color("detailBG")],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .ignoresSafeArea() // ensure gradient also covers safe areas
                }
        })
        .overlay(alignment: .bottom) {
            HStack{
                Button {
                    
                } label: {
                    Image(systemName: "map.fill")
                        .padding()
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(Color.white, lineWidth: 1)
                        }
                }
                HStack(spacing: 12) {
                    Image(systemName: "location.fill")
                        .foregroundStyle(.white.opacity(0.9))
                        .font(.system(size: 12, weight: .semibold))

                    // Replace with a @State page index if you have paging
                    PageDots(count: 7, current: 2)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
                .background(
                    Capsule().fill(Color.white.opacity(0.08))
                )
                .overlay(
                    Capsule().stroke(Color.white.opacity(0.35), lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 2)
                //.padding(.bottom, 24)

                Button {
                    dismiss()
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .padding()
                        .font(.system(size: 20))
                        .foregroundStyle(.white)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(Color.white, lineWidth: 1)
                        }
                }
            }
            //.background(.yellow)
        }
    }

    var verticalDetail: some View{
        VStack{
            Text(data.cityName)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                
            Text("\(data.temp)°")
                .font(.system(size: 100, weight: .bold, design: .rounded))
            Text(data.description)
                .font(.system(size: 20, weight: .bold, design: .rounded))
            Text(data.hl)
        }
        .foregroundStyle(.white)
        .padding(.top, 50)
    }
    var horizontalDetail: some View{
        VStack{
            Text(data.cityName)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
            HStack{
                Text("\(data.temp)°")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                Text("|")
                Text(data.description)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            .foregroundStyle(.white)
        }
    }
    
    var timeAndTempView: some View{
        Section {
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(timeData, id: \.self) { data in
                        VStack(alignment: .center, spacing: 20) {
                            
                            Text(data.time)
                                .font(.footnote)
                                .foregroundColor(.white)
                            Image(systemName: data.icon)
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.white)
                            Text(data.temp)
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        } header: {
            Text("Whether conditions will continue for the rest of the day. Winds gusting to 10 mph.")
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
    var tenDayForecast: some View{
        Section {
            VStack{
                ForEach(dayForeCast) { val in
                    HStack(spacing: 20){
                        Text(val.day)
                            .font(Font.system(.title, design: .rounded))
                            .foregroundStyle(Color.white)
                        
                        Image(systemName: val.icon)
                            .foregroundStyle(.white)
                            .font(Font.system(.title3, design: .rounded))
                        Text(val.tempMin)
                            .font(Font.system(.title3, design: .rounded))
                            .foregroundStyle(Color.white)
                        ProgressView(value: val.progess, total: 100)
                            .frame(width: 50, height: 10)
                        Text(val.tempMax)
                            .font(Font.system(.title3, design: .rounded))
                            .foregroundStyle(Color.white)
                    }
                    if val.id != 10{
                        Divider().background(Color.blue)
                    }
                    //Divider().background(Color.blue)

                }
            }
        }
        header: {
            HStack{
                Image(systemName: "calendar")
                    .foregroundStyle(.white)
                Text("10-Day Forecast")
                    .font(.footnote)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
    
    var feelLikeView: some View {
        HStack(spacing: 20) {
            // Card 1
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "thermometer.variable.and.figure")
                        .foregroundStyle(.white)
                    Text("FEELS LIKE")
                        .font(.footnote)
                        .foregroundColor(.white)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("27°C")
                        .foregroundStyle(.white)
                        .font(.system(.title, design: .rounded))
                    Text("It feels warmer than the actual temperature.")
                        .foregroundStyle(.white)
                        .font(.footnote)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            // Card 2
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: "sun.min.fill")
                        .foregroundStyle(.white)
                    Text("UV INDEX")
                        .font(.footnote)
                        .foregroundColor(.white)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 8) {
                    Text("0")
                        .foregroundStyle(.white)
                        .font(.system(.title, design: .rounded))
                    Text("Low")
                        .foregroundStyle(.white)
                        .font(.system(.title3, design: .rounded))
                    Text("Low for the rest of the day.")
                        .foregroundStyle(.white)
                        .font(.footnote)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(.black.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(maxHeight: .infinity)
    }
}

struct TimeData: Identifiable, Hashable {
    var id: Int
    var time: String
    var icon: String
    var temp: String
}
struct DayForecast: Identifiable, Hashable {
    var id: Int
    var day: String
    var icon: String
    var tempMin: String
    var tempMax: String
    var rainPercent: Int
    var progess: Float
}
struct PageDots: View {
    let count: Int
    let current: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<count, id: \.self) { i in
                Circle()
                    .fill(i == current ? .white : .white.opacity(0.4))
                    .frame(width: i == current ? 8 : 6, height: i == current ? 8 : 6)
            }
        }
    }
}
#Preview {
    CityDetailView(data: WheatherInfo(id: 1, cityName: "Kolkata", temp: "40", description: "Heavy rain", icon: "mostlyCloudy", time: "8:05 PM", hl: "H: 34° | L: 26°"))
}

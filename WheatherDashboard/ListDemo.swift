//
//  ListDemo.swift
//  WheatherDashboard
//
//  Created by Pradeep Kumar Sagar on 23/06/26.
//

import SwiftUI

struct ListDemo: View {
    var body: some View {
        ZStack{
            Image("mostlyCloudy")
                .resizable()
                .ignoresSafeArea()
                
            List {
                Section(header: Text("Section 1")) {
                    Text("Row 1")
                    Text("Row 2")
                }
                Section(header: Text("Section 2")) {
                    Text("Row 1")
                    Text("Row 2")
                }
            }
            .scrollContentBackground(.hidden)
        }
       
    }
}

#Preview {
    ListDemo()
}

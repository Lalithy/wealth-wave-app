//
//  DashboardView.swift
//  WealthWave
//
//  Created by Lali.. on 19/09/2023.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        
        VStack{
            
            
            BottomControllers()
        }
        
    }
}


struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}


struct BottomControllers: View {
    var body: some View {
        TabView {
            
            AddItemsView()
                .tabItem {
                    Image(systemName: "square.grid.3x1.folder.fill.badge.plus")
                        //.renderingMode(.original)
                    Text("Add Items")
                }
            Text("Pie Chart View")
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Dashboard")
                }
            Text("Trello View")
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                    Text("Budget")
                }
            
            Text("File Plus View")
                .tabItem {
                    Image(systemName: "list.bullet.clipboard.fill")
                    Text("Report")
                }
        }
    }
}

//
//  DashboardView.swift
//  WealthWave
//
//  Created by Lali.. on 19/09/2023.
//

import SwiftUI


struct DashboardView: View {

    @State private var isLogoutTapped = false

    let gradientScreen = Gradient(colors: [Color("ScreenColorTop"), Color("ScreenColorMiddle"), Color("ScreenColorEnd")])
    var body: some View {

        VStack{

            BottomControllers()
        }
        .background(LinearGradient(gradient: gradientScreen, startPoint: .top, endPoint: .bottom))
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing:
                       NavigationLink(destination: Preview()) {
                           Image(systemName: "arrow.right.circle")
                           .font(.system(size: 20))
                           .padding(.trailing, 20)
                       }
                   )

    }
}


struct BottomControllers: View {

    var body: some View {
        TabView {

            ChartsView()
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                    Text("Dashboard")
                }
            AddItemsView()
                .tabItem {
                    Image(systemName: "square.grid.3x1.folder.fill.badge.plus")

                    Text("Add Items")
                }

            BudgetView()
                .tabItem {
                    Image(systemName: "chart.bar.doc.horizontal")
                    Text("Budget")
                }

            ReportView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard.fill")
                    Text("Report")
                }
        }
    }
}


struct DashboardView_Previews: PreviewProvider {
  
    static var previews: some View {
        DashboardView()
    }
}

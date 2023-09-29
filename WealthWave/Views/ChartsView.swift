//
//  ChartsView.swift
//  WealthWave
//
//  Created by Lali.. on 27/09/2023.
//

import SwiftUI
import Charts

struct ChartsView: View {
    
    @State private var selectedSide: SideOfTheForce = .chart
    
    var body: some View {
        
        VStack {
            Picker("Coose a Side", selection: $selectedSide) {
                ForEach(SideOfTheForce.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            Spacer()
            ChosenBackgroundView(selectedSide: selectedSide)
            Spacer()
        }
        .padding()
        
    }
}

enum SideOfTheForce: String, CaseIterable {
    case chart = "Chart"
    case statistics = "Statistics"
}

struct ChosenBackgroundView: View {
    
    var selectedSide: SideOfTheForce
    
    var body: some View {
        switch selectedSide {
        case .chart:
            BackgroundView(backgroundName: "Chart", selectedSide: selectedSide)
        case .statistics:
            BackgroundView(backgroundName: "Last Six Month Expenses", selectedSide: selectedSide)
        }
    }
}

struct BackgroundView: View {
    
    var backgroundName : String
    var selectedSide : SideOfTheForce

    @StateObject var userChartExpensesList: ChartsViewModel = ChartsViewModel()
    @StateObject var userChartExpensesCategoryList: ChartsExpensesCategoryViewModel = ChartsExpensesCategoryViewModel()
    
    var body: some View {
        
        
        if selectedSide == .statistics {
            ScrollView {
                VStack (alignment: .leading, spacing: 10){
                    Text(backgroundName)
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .font(.system(size: 25))
                    
                    Chart {
                        ForEach(userChartExpensesList.chartExpenses, id: \.month) { expenses in
                            
                            BarMark(
                                x: .value("Month", expenses.month),
                                y: .value("Expense", expenses.expenseTotal)
                            )
                            .cornerRadius(8)
                            .foregroundStyle(by: .value("Month", expenses.month))
                            
                        }
                    }
                    
                    .chartLegend(position: .bottom, alignment: selectedSide == .statistics ? .leading: .center, spacing: 25)
                    .frame(height:250)
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Text(backgroundName)
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .font(.system(size: 25))
                    
                    Chart {
                        ForEach(userChartExpensesList.chartExpenses,id: \.month) { expenses in
                            
                            LineMark(x: .value("Month", expenses.month),
                                     y: .value("Expense", expenses.expenseTotal)
                            )
                            .foregroundStyle(.green)
                            
                        }
                    }
                    .frame(height:150)
                }
                .padding(.top, 40)
            }
        } else {
            
            ScrollView {
                
                Text ("Expense Dashboard")
                
                VStack {

                    GeometryReader {g in

                        ZStack {

                            ForEach(0..<userChartExpensesCategoryList.chartExpensesCategory.count, id: \.self){i in
                                DrawShape(center: CGPoint(x: g.frame(in: .global).width / 2, y: g.frame(in: .global).height / 2), index: i, chartExpensesCategoryList: userChartExpensesCategoryList)
                            }
                        }
                    }
                    .frame(height: 360)
                    .padding()
                    .clipShape(Circle())
                    .shadow(radius: 5)

                    VStack {

                        ForEach(userChartExpensesCategoryList.chartExpensesCategory,id: \.budgetCategory) { i in

                            HStack {

                                Text(i.budgetCategory)
                                    .frame(width: 150, alignment: .leading)

                                GeometryReader {g in
                                    HStack {

                                        Spacer(minLength: 0)

                                        Rectangle()
                                            .fill(Color(i.budgetCategory))
                                            .frame(width: self.getWidth(width: g.frame(in: .global).width, value: i.expensePercentage), height: 10)

                                        Text(String(format: "%.2f", i.expensePercentage)+" %")
                                            .fontWeight(.bold)
                                            .padding(.leading, 6)
                                    }

                                }

                            }
                            .padding(.top, 6)
                        }
                    }
                    .padding()
                    Spacer()

                }
                .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    func getWidth(width: CGFloat, value: CGFloat)->CGFloat {
        
        let temp = value / 100
        return temp * width
    }
}


struct DrawShape : View {
    
    var center : CGPoint
    var index : Int
    
    var chartExpensesCategoryList: ChartsExpensesCategoryViewModel
    
    var body: some View {
        
        Path {path in
            path.move(to: self.center)
            path.addArc(center: self.center, radius: 180, startAngle: .init(degrees: self.from()), endAngle: .init(degrees: self.to()), clockwise: false)
        }
        .fill(Color(chartExpensesCategoryList.chartExpensesCategory[index].budgetCategory))
    }
    
    func from()->Double {
        
        if index == 0 {
            return 0
        } else {
            var temp : Double = 1
            
            for i in 0...index-1{
                temp += Double(chartExpensesCategoryList.chartExpensesCategory[i].expensePercentage / 100) * 360
            }
            return temp
        }
    }
    
    func to()->Double {

        var temp : Double = 0

        for i in 0...index{
            temp += Double(chartExpensesCategoryList.chartExpensesCategory[i].expensePercentage / 100) * 360
        }
        return temp
    }
    
}


struct ChartsView_Previews: PreviewProvider {
    static var previews: some View {
        ChartsView()
    }
}

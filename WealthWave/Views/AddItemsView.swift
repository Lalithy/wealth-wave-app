//
//  AddItemsView.swift
//  WealthWave
//
//  Created by Lali.. on 20/09/2023.
//

import SwiftUI


struct AddItemsView: View {
    @State private var selectedTab = 0
    @State private var isListVisible = false
    
    var body: some View {
        VStack {
            // Custom Tab Bar
            HStack {
                TabBarButton(title: "EXPENSES", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                TabBarButton(title: "INCOME", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
                TabBarButton(title: "SAVINGS", isSelected: selectedTab == 2) {
                    selectedTab = 2
                }
            }
            .padding(.vertical, 10)
            
            // Tab Content
            TabView(selection: $selectedTab) {
                
                VStack {
                    Text("")
                        .tag(0)
                    
                    Spacer()
                    
                    NavigationLink(
                        destination: ListOfExpensesView(),
                        isActive: $isListVisible
                    ) {
                        
                    }
                    .hidden()
                    
                    Button(action: {
                        
                        isListVisible = true
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.blue)
                    }
                    .padding(.bottom, 20)
                    .padding(.trailing, 20)
                    
                }
                
                Text("Income Content")
                    .tag(1)
                
                Text("Savings Content")
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct TabBarButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(isSelected ? .headline : .subheadline)
                .foregroundColor(isSelected ? .mint : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(isSelected ? Color.blue.opacity(0.2) : Color.clear)
                .cornerRadius(10)
        }
    }
}

struct AddItemsView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemsView()
    }
}

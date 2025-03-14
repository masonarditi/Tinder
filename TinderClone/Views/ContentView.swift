//
//  ContentView.swift
//  TinderClone
//
//  Created by JD on 20/08/20.
//

import SwiftUI

struct Tab {
    let id: Int
    let name: String
    let color: Color
    let image: String
    
    static let tabs = [
        Tab(id: 0, name: "home", color: .electricPink, image: "flame.fill"),
        Tab(id: 1, name: "likes", color: .gold, image: "sparkles"),
        Tab(id: 2, name: "messages", color: .electricPink, image: "message.fill"),
        Tab(id: 3, name: "profile", color: .electricPink, image: "person.fill")
    ]
}

import SwiftUI

struct ContentView: View {
    // 1) Accept a Binding so we can manage login state
    @Binding var isLoggedIn: Bool
    
    let tabs = Tab.tabs
    @State private var selectedTab: Int = 0
    @State var isLoading: Bool = true
    
    var body: some View {
        Group {
            if isLoading {
                LoadingView()
            } else {
                VStack {
                    // The top bar of icons
                    HStack {
                        Spacer()
                        ForEach(tabs, id: \.id) { tab in
                            Image(systemName: tab.image)
                                .font(.system(size: 25))
                                .foregroundColor(tab.id == selectedTab
                                                 ? tab.color
                                                 : Color.gray.opacity(0.7))
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        selectedTab = tab.id
                                    }
                                }
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 45)
                    
                    // The TabView with subviews
                    TabView(selection: $selectedTab) {
                        HomeView()
                            .tag(0)
                        LikesView()
                            .tag(1)
                        MessagesView()
                            .tag(2)
                        // passes isLoggedIn logic
                        ProfileView(isLoggedIn: $isLoggedIn)
                            .tag(3)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
                .background(Color(UIColor.systemGroupedBackground)
                                .edgesIgnoringSafeArea(.all))
            }
        }
        .onAppear {
            onAppearCalled()
        }
    }
    
    private func onAppearCalled() {
        // Example: 4-second loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            isLoading = false
        }
    }
}


//
//  MainTabView.swift
//  Soongan
//
//  Created by 김민 on 6/20/24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: MainTabType = .home

    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case .home:
                ContestOutlineView()
            case .gallery:
                // TODO: - gallery tab
                VStack {
                    Spacer()
                    Text("new view")
                }
            case .award:
                // TODO: - award tab
                VStack {
                    Spacer()
                    Text("new view")
                }
            case .my:
               // TODO: - my tab
                VStack {
                    Spacer()
                    Text("new view")
                }
            }

            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}


fileprivate struct CustomTabBar: View {
    @Binding var selectedTab: MainTabType

    var body: some View {
        HStack {
            ForEach(MainTabType.allCases, id: \.self) { tab in
                Spacer()
                VStack(spacing: 0) {
                    Image(tab.imageName(selected: selectedTab == tab))
                        .padding(.top, 16)
                        .onTapGesture {
                            selectedTab = tab
                        }
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(height: 83)
        .background(
            Rectangle()
                .fill(.white.shadow(.drop(color: Color(hex: 0x000000, alpha: 0.25),
                                          radius: 4,
                                          x: 0,
                                          y: -2)))
        )
    }
}

#Preview {
    MainTabView()
}

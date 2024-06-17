//
//  ContestView.swift
//  Soongan
//
//  Created by 김민 on 6/9/24.
//

import SwiftUI

struct ContestView: View {

    var body: some View {
        TabView(selection: .constant(2)) {
            Text("참여하기")
                .tag(1)
            ContestOutlineView()
                .tag(2)
            Text("갤러리로")
                .tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .ignoresSafeArea()
        .toolbar(.hidden)
    }
}

#Preview {
    ContestView()
}


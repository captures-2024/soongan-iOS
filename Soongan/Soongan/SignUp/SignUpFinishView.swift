//
//  SignUpFinishView.swift
//  Soongan
//
//  Created by jun on 5/16/24.
//

import SwiftUI

struct SignUpFinishView: View {
    var body: some View {
        Spacer()
        VStack(spacing: 0) {
            Text("환영합니다")
            Spacer()
            Text("김첨지님!")
        }
        .font(.system(size: 36, weight: .semibold))
        .frame(height: 132)
        Spacer()
    }
}

#Preview {
    SignUpFinishView()
}

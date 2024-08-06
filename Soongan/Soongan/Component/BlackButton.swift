//
//  BlackButton.swift
//  Soongan
//
//  Created by 김민 on 8/6/24.
//

import SwiftUI

struct BlackButton: View {
    let title: String
    let action: () -> ()

    var body: some View {
        Button {

        } label: {
            Text(title)
                .font(.system(size: 14))
                .foregroundStyle(Color.white)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(Color.primaryA)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}

#Preview {
    BlackButton(title: "버튼 제목") {
        print("clicked")
    }
}

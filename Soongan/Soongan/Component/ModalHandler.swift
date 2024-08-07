//
//  ModalHandler.swift
//  Soongan
//
//  Created by 김민 on 8/7/24.
//

import SwiftUI

struct ModalHandler: View {

    var body: some View {
        RoundedRectangle(cornerRadius: 100)
            .foregroundStyle(Color.primaryA)
            .frame(width: 40, height: 4)
            .padding(.top, 14)
    }
}

#Preview {
    ModalHandler()
}

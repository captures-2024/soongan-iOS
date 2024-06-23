//
//  CircleButton.swift
//  Soongan
//
//  Created by 김민 on 6/23/24.
//

import SwiftUI

struct CircleButton: View {
    let imageName: String
    let action: () -> Void

    init(imageName: String, action: @escaping () -> Void) {
        self.imageName = imageName
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            Image(imageName)
                .frame(width: 44, height: 44)
                .background(.white)
                .clipShape(Circle())
                .background {
                    Circle()
                        .fill(Color.white.shadow(.drop(color: Color.black.opacity(0.25),
                                                       radius: 4,
                                                       x: 0,
                                                       y: 2)))
                }
        }
    }
}

#Preview {
    CircleButton(imageName: "icInfo") {
        print("Circle Button Tapped")
    }
}

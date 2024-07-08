//
//  ExhibitedImageCell.swift
//  Soongan
//
//  Created by 김민 on 7/7/24.
//

import SwiftUI

struct ExhibitedImageCell: View {
    let imageURL: String
    let heartCount: Int
    let commentCount: Int
    let imageSizeChanged: (CGFloat) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            AsyncImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
                    .frame(height: Constants.screenHeight * (257/852))
                    .scaledToFit()
                    .background {
                        ZStack {
                            Rectangle()
                                .fill(Color.white.shadow(.drop(color: Color.black.opacity(0.25),
                                                               radius: 3,
                                                               x: 6,
                                                               y: 6)))
                            Rectangle()
                                .fill(Color.white.shadow(.drop(color: Color.black.opacity(0.25),
                                                               radius: 4,
                                                               x: -4,
                                                               y: 4)))
                        }
                    }
                    .background(
                        GeometryReader { geometry in
                             Color.clear
                                 .onAppear {
                                     imageSizeChanged(geometry.size.width)
                                 }
                         }
                    )
            } placeholder: {
                ProgressView()
                    .frame(height: Constants.screenHeight * (257/852))
            }

            HStack(spacing: 16) {
                HStack(spacing: 4) {
                    Image("icHeartFill")
                    Text("\(heartCount)")
                }
                .font(.system(size: 12))

                HStack(spacing: 4) {
                    Image("icCommentBlack")
                    Text("\(commentCount)")
                }
                .font(.system(size: 12))
            }
        }
    }
}

#Preview {
    ExhibitedImageCell(imageURL: "https://picsum.photos/seed/picsum/200/300",
                       heartCount: 333,
                       commentCount: 333) { _ in }
}

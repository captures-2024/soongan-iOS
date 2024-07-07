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

    @State private var imageSize: CGSize = .zero

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
                                     let width = geometry.size.width
                                     print("size: ", width)
                                     imageSizeChanged(width)
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
                    Text("350")
                }
                .font(.system(size: 12))

                HStack(spacing: 4) {
                    Image("icCommentBlack")
                    Text("350")
                }
                .font(.system(size: 12))
            }
        }
    }
}

struct CustomAsyncImage: View {
    let url: URL?

    @State private var imageSize: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in

            if let url = url {

                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .onAppear {
                            let size = geometry.size

                            if size != .zero {
                                self.imageSize = size
                                print("📌", size)
                            }
                        }
                } placeholder: {
                    ProgressView()
                }

            } else {
                Color.gray
            }
        }
    }
}


#Preview {
    ExhibitedImageCell(imageURL: "https://picsum.photos/seed/picsum/200/300",
                       heartCount: 333,
                       commentCount: 333) { _ in }
}

//
//  CommentView.swift
//  Soongan
//
//  Created by 김민 on 7/22/24.
//

import SwiftUI

struct CommentView: View {
    var body: some View {
        VStack {
            Spacer(minLength: 28)

            Text("댓글")
                .font(.system(size: 16, weight: .bold))
                .padding(.bottom, 8)

            Divider()

            ScrollView {
                ForEach(0..<3) {_ in
                    CommentCell()
                }
            }
        }
    }
}

fileprivate struct CommentCell: View {

    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .frame(width: 36, height: 36)
                .foregroundStyle(Color.init(hex: 0xD9D9D9))

            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("user1")

                    Spacer()

                    Button {
                        // TODO: 모달
                    } label: {
                        Image("icEllipsis")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
                .padding(.bottom, 4)

                Text("댓글 내용")
                    .padding(.bottom, 8)

                HStack {
                    Button {

                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "heart")
                                .font(.system(size: 16))

                            Text("2")
                                .font(.system(size: 12))
                        }
                        .foregroundStyle(Color.primaryA)
                    }
                    .padding(.trailing, 32)

                    Button {

                    } label: {
                        Text("답글 달기")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(Color.primaryA)
                            .opacity(0.9)
                    }

                    Spacer()

                    Text("15시간 전")
                        .padding(.trailing, 8)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.primaryA)
                        .opacity(0.6)

                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 12)
    }
}

#Preview {
    CommentView()
}

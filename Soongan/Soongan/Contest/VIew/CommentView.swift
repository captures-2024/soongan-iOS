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
            .padding(.horizontal, 12)
        }
    }
}

fileprivate struct CommentCell: View {

    @State private var isReplyOpened: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            CommonCommentCell(isParent: true)

            if !isReplyOpened {
                Button {
                    isReplyOpened.toggle()
                } label: {
                    HStack {
                        Rectangle()
                            .frame(width: 27, height: 1)

                        Text("답글 3개 더 보기")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .foregroundStyle(Color.primaryA)
                    .opacity(0.9)
                    .padding(.top, 12)
                    .padding(.leading, 44)
                }
            }

            if isReplyOpened {
                Group {
                    ForEach(0..<3) { _ in
                        CommonCommentCell(isParent: false)
                    }

                    Button {
                        isReplyOpened.toggle()
                    } label: {
                        HStack {
                            Rectangle()
                                .frame(width: 27, height: 1)

                            Text("답글 숨기기")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundStyle(Color.primaryA)
                        .opacity(0.9)
                        .padding(.top, 12)
                        .padding(.leading, 36)
                    }
                }
                .padding(.leading, 44)
            }
        }
    }
}

fileprivate struct CommonCommentCell: View {
    var isParent: Bool

    var body: some View {
        HStack(alignment: .top) {
            Circle()
                .frame(width: isParent ? 36 : 28)
                .aspectRatio(1.0, contentMode: .fit)
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

                Text("댓글 내용임")
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
                        .padding(.trailing, 28)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.primaryA)
                        .opacity(0.6)

                }
            }
        }
        .padding(.top, 16)
        .padding(.bottom, 4)
    }
}

#Preview {
    CommentView()
}

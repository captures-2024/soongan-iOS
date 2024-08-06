//
//  CommentView.swift
//  Soongan
//
//  Created by 김민 on 7/22/24.
//

import SwiftUI

struct CommentView: View {
    @State private var comment: String = ""

    @Binding var isCommentBottomSheetOpened: Bool

    var body: some View {
        VStack {
            Spacer(minLength: 28)

            Text("댓글")
                .font(.system(size: 16, weight: .bold))
                .padding(.bottom, 8)

            Divider()

            ScrollView {
                ForEach(0..<3) {_ in
                    CommentCell(isCommentBottomSheetOpened: $isCommentBottomSheetOpened)
                }
            }
            
            commentTextField
        }
        .background(Color.white)
        .sheet(isPresented: $isCommentBottomSheetOpened) {
            CommentPlusBottomView()
                .presentationDetents([.height(240)])
                .presentationDragIndicator(.visible)
        }
    }

    private var commentTextField: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(Color.primaryA)
                .opacity(0.3)

            HStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.init(hex: 0xD9D9D9))

                TextField(
                    "",
                    text: $comment,
                    prompt: Text("댓글을 작성해 주세요"),
                    axis: .vertical
                )
                .padding(.leading, 16)
                .padding(.vertical, 13)
                .tint(.primaryA)
                .font(.system(size: 14, weight: .regular))
                .overlay {
                    RoundedRectangle(cornerRadius: 202)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)

                    if !comment.isEmpty {
                        HStack {
                            Spacer()

                            Button {
                                // TODO: send action
                            } label: {
                                Image("sendButton")
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 8)
            .padding(.leading, 12)
            .padding(.trailing, 16)
        }
    }
}

#Preview {
    CommentView(isCommentBottomSheetOpened: .constant(true))
}

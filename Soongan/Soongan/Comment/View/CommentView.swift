//
//  CommentView.swift
//  Soongan
//
//  Created by 김민 on 7/22/24.
//

import SwiftUI

struct CommentView: View {
    @State private var comment: String = ""
    @Binding var isCommentSheetOpened: Bool
    @Binding var isCommentBottomSheetOpened: Bool
    @Binding var selectedReportViewType: ReportViewType

    var body: some View {
        VStack(spacing: 0) {
            ModalHandler()
                .padding(.bottom, 10)

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
        .overlay {
            if isCommentBottomSheetOpened {
                Color.primaryA.opacity(0.5)
                         .edgesIgnoringSafeArea(.all)
                         .transition(.opacity)
                         .onTapGesture {
                             isCommentBottomSheetOpened.toggle()
                         }

                commentBottomModalView
            }
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

    private var commentBottomModalView: some View {
        VStack {
            Spacer()
            CommentPlusBottomView(
                isCommentOpened: $isCommentSheetOpened,
                isCommentBottomSheetOpened: $isCommentBottomSheetOpened,
                selectedReportView: $selectedReportViewType
            )
            .background(Color.white)
            .cornerRadius(20)
            .frame(maxWidth: .infinity, maxHeight: 240)
            .zIndex(1)
        }
        .edgesIgnoringSafeArea(.bottom)
        .gesture(
            DragGesture()
                .onChanged { _ in
                    isCommentBottomSheetOpened.toggle()
                }
        )
    }
}

#Preview {
    CommentView(
        isCommentSheetOpened: .constant(true),
        isCommentBottomSheetOpened: .constant(true),
        selectedReportViewType: .constant(.reportCase)
    )
}

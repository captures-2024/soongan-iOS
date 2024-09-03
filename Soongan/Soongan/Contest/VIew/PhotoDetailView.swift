//
//  PhotoDetailView.swift
//  Soongan
//
//  Created by juni on 6/17/24.
//

import SwiftUI

struct PhotoDetailView: View {
    // 사진 전체화면 클릭
    @State private var isImageLarge = false
    @State private var isCommentSheetOpened = false
    @State private var isCommentBottomSheetOpened = false
    @State private var selectedReportView = ReportViewType.none

    @StateObject var appState = AppState.shared

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Image("galleryBackground")
                    .resizable()
                    .frame(width: Constants.screenWidth)
                    .ignoresSafeArea(.all)

                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        CapturesNavigationBar()
                        Spacer()
                    }
                    .padding(.top, 68)
                    .padding(.bottom, 71)

                    ScrollView {
                        Image("background")
                            .resizable()
                            .frame(width: Constants.screenWidth - 40, height: Constants.screenWidth - 40)
                            .padding(.bottom, 138)
                        HStack(spacing: 0) {
                            Text("무제")
                                .padding(.leading, 36)
                            Spacer()
                        }
                        HStack(spacing: 0) {
                            Text("@dkddkq222")
                                .padding(.leading, 36)
                            Spacer()
                        }

                    }
                }

                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        // 정보 더보기 버튼
                        Button {

                        } label: {
                            Image("plusInfoButton")
                                .renderingMode(.template)
                                .foregroundStyle(Color.black)
                        }
                        .padding(.leading, 16)
                        Spacer()

                        // 좋아요 버튼
                        Button {

                        } label: {
                            Image("icHeart")
                                .renderingMode(.template)
                                .foregroundStyle(Color.black)
                        }
                        .padding(.trailing, 8)

                        Text("1.2m")
                            .padding(.trailing, 31)

                        // 댓글 버튼
                        Button {
                            isCommentSheetOpened.toggle()
                        } label: {
                            Image("icComment")
                                .renderingMode(.template)
                                .foregroundStyle(Color.black)
                        }
                        .padding(.trailing, 8)
                        Text("1.2m")
                            .padding(.trailing, 31)

                    }

                }
                .frame(width: Constants.screenWidth, height: 63)
                .background(.white)
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)

                if isCommentBottomSheetOpened {
                    modalBlackView
                        .onTapGesture {
                            isCommentBottomSheetOpened = false
                        }
                }

                if selectedReportView != .none {
                    modalBlackView
                        .onTapGesture {
                            selectedReportView = .none
                            isCommentSheetOpened = true
                        }
                }

                reportModalView

            }
            .toolbar(.hidden)
            .sheet(
                isPresented: $isCommentSheetOpened,
                onDismiss: { isCommentBottomSheetOpened = false }
            ) {
                CommentView(
                    isCommentSheetOpened: $isCommentSheetOpened,
                    isCommentBottomSheetOpened: $isCommentBottomSheetOpened,
                    selectedReportViewType: $selectedReportView
                )
                .presentationDetents([.height(600)])
            }
            .onChange(of: selectedReportView) { newValue in
                if newValue == .completed {
                    isCommentSheetOpened = true
                    selectedReportView = .none
                }
            }
        }
    }

    private var modalBlackView: some View {
        Color.primaryA.opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .transition(.opacity)
    }

    private var reportModalView: some View {
        ReportModalView(mode: $selectedReportView) {
            Group {
                switch selectedReportView {
                case .reportCase:
                    ReportCasesView(selectedReportView: $selectedReportView)

                case let .submitReport(reportCase):
                    SubmitReportView(
                        selectedReportViewType: $selectedReportView,
                        reportCase: reportCase
                    )

                case .reportCompleted:
                    ReportCompletedView(selectedReportView: $selectedReportView)

                case .none, .completed:
                    EmptyView()
                }
            }
        }
        .ignoresSafeArea()
    }
}


#Preview {
    PhotoDetailView()
}

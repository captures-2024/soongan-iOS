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
        ZStack {
            Image("galleryBackground")
                .resizable()
                .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ZStack {
                    HStack(spacing: 0){
                        CapturesNavigationBar()
                        Spacer()
                    }
                    Text("")
                        .font(.system(size: 24, weight: .medium))
                }
                .padding(.bottom, 86)
                .padding(.top, 73)

                ScrollView {
                    ZStack {
                        Image("background")
                            .resizable()
                            .frame(width: Constants.screenWidth - 40, height: isImageLarge ? Constants.screenWidth + 100 : Constants.screenWidth - 40)

                        VStack(spacing: 0) {
                            HStack(spacing: 0) {

                                Spacer()
                                Button(action: {
                                }, label: {

                                    Image("plusInfoButton")
                                        .frame(width: 30, height: 30)
                                })

                            }
                            Spacer()

                        }
                        VStack(spacing: 0) {
                            Spacer()
                            HStack(spacing: 0) {
                                Spacer()
                                Button(action: {
                                    withAnimation(nil) {
                                        isImageLarge.toggle()
                                    }

                                }, label: {
                                    Image("viewAllButton")
                                        .padding(.bottom, 8)
                                        .padding(.trailing, 8)
                                })
                            }

                        }
                    }
                    .frame(width: Constants.screenWidth - 40, height: isImageLarge ? Constants.screenWidth + 100 : Constants.screenWidth - 40)
                    .padding(.bottom, 40)

                    HStack(spacing: 0) {
                        Spacer()
                        ZStack {
                            Rectangle()
                                .frame(width: 289, height: 124)
                            HStack(spacing: 0) {
                                VStack(alignment: .leading, spacing: 12) {
                                    Text("무제")
                                        .font(.system(size: 20, weight: .medium))
                                    Text("@dkdkkq222")
                                        .font(.system(size: 14, weight: .medium))
                                    HStack(spacing: 0) {
                                        Text("D _ 1회차 | 평화")
                                            .font(.system(size: 12, weight: .medium))
                                        Spacer()
                                        HStack(spacing: 24) {
                                            Button {

                                            } label: {
                                                Image("icShare")
                                            }
                                            Button {

                                            } label: {
                                                Image("icHeart")
                                            }
                                            Button {
                                                isCommentSheetOpened = true
                                            } label: {
                                                Image("icComment")
                                            }

                                        }
                                        .padding(.trailing, 20)

                                    }

                                }
                                .foregroundStyle(.white)
                                .padding(.leading, 16)
                                Spacer()
                            }
                            .frame(width: 289, height: 124)

                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 63)

                    }

                    Spacer()
                }
            }

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
    }
}


#Preview {
    PhotoDetailView()
}

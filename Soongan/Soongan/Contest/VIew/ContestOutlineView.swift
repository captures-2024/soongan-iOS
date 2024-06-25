//
//  ContestOutlineView.swift
//  Soongan
//
//  Created by 김민 on 6/16/24.
//

import SwiftUI

enum ContestMode: String, CaseIterable {
    case weekly = "일간"
    case daily = "주간"
}

struct ContestOutlineView: View {
    @State private var contestMode = ContestMode.weekly

    @StateObject private var viewModel = ContestOutlineViewModel()

    var body: some View {
        ZStack {
            Color.primaryB
                .ignoresSafeArea(.all)

            Image("mainBackground")
                .resizable()
                .ignoresSafeArea(.all)

            VStack(spacing: 0) {
                Spacer(minLength: 20)

                titleView
                    .padding(.bottom, 68)

                exhibitView
                    .padding(.bottom, 52)

                ContestModeSegmentedControl(selection: $contestMode)
                    .padding(.bottom, 16)

                dateDescriptionView
                    .padding(.bottom, 32)

                HStack {
                    VStack {
                        CircleButton(imageName: "icInfo") {
                            // TODO: - 대회 정보
                        }
                        Text("대회정보")
                    }
                    Spacer()
                    VStack {
                        CircleButton(imageName: "icRight") {
                            // TODO: - 참가 작품
                        }
                        Text("참가작품")
                    }
                }
                .padding(.horizontal, 28)
                .font(.system(size: 12, weight: .regular))

                Spacer(minLength: 20)
            }
        }
    }

    private var titleView: some View {
        HStack {
            ZStack(alignment: .leading) {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(Color.accent)
                    .offset(x: -20, y: -20)
                Text("평화")
                    .font(.system(size: 42, weight: .bold))
            }
            Spacer()
            Image("soonganLogo")
                .shadow(color: .black.opacity(0.25),
                        radius: 2,
                        x: 0,
                        y: 2)
        }
        .padding(.horizontal, 36)
    }

    @ViewBuilder
    private var exhibitView: some View {
        if viewModel.exhibitedCount == 0 {
            Button {
                // TODO: - 출품 로직
            } label: {
                ZStack {
                    Rectangle()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(minHeight: 100, maxHeight: 257)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black.opacity(0.25),
                                radius: 4,
                                x: 0,
                                y: 4)
                    VStack(spacing: 16) {
                        Image("icPlus")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("출품하기")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color.primaryA)
                    }
                }
            }
        } else {
            VStack(alignment: .leading ,spacing: 12) {
                HStack(alignment: .top, spacing: 16) {
                    Button {
                        // TODO: - 출품 로직
                    } label: {
                        Button {
                            // TODO: - 출품 로직
                        } label: {
                            Group {
                                Image(viewModel.exhibitedCount < 3 ? "icPlus" : "icPlusWhite")
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            }
                            .frame(width: 60)
                            .frame(minHeight: 150, maxHeight: 257)
                            .background {
                                VStack {
                                    Spacer()
                                    Text("\(viewModel.exhibitedCount)/3")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundStyle(viewModel.exhibitedCount < 3 ? Color.primaryA : Color.white)
                                        .padding(.bottom, 24)
                                }
                            }
                            .background {
                                Rectangle()
                                    .fill(viewModel.exhibitedCount < 3 ? Color.white : Color.init(hex: 0xBEBEBE))
                                    .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    .disabled(viewModel.exhibitedCount == 3)

                    VStack(alignment: .leading, spacing: 12) {
                        // TODO: - 이미지 로직
                        Image("background")
                            .resizable()
                            .frame(width: 200)
                            .frame(minHeight: 100, maxHeight: 257)
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
                    }
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
                .padding(.leading, 80)
            }
        }
    }

    private var dateDescriptionView: some View {
        HStack {
            Spacer()
            VStack {
                Text("시작 일정 | 2024.05.10")
                Text("마감 일정 | 2024.05.10")
            }
            .font(.system(size: 14, weight: .bold))
        }
        .padding(.horizontal, 36)
    }
}


struct ContestModeSegmentedControl: View {
    @Binding var selection: ContestMode

    var body: some View {
        HStack {
            Spacer()
            HStack(spacing: 0) {
                ForEach(ContestMode.allCases, id: \.self) { mode in
                    ZStack {
                        RoundedRectangle(cornerRadius: 4)
                            .foregroundColor(selection == mode ? .black : Color.clear)
                        Text(mode.rawValue)
                            .foregroundColor(selection == mode ? .white : Color.init(hex: 0xC3C3C3))
                            .font(.system(size: 16, weight: .bold))
                    }
                    .onTapGesture {
                        selection = mode
                    }
                }
            }
            .frame(width: 158, height: 32)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 2, y: 2)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    ContestOutlineView()
}

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
    @State private var contentWidth: CGFloat = 60

    @StateObject private var viewModel = ContestOutlineViewModel()

    var body: some View {
        ZStack {
            Color.primaryB
                .ignoresSafeArea(.all)

            Image("mainBackground")
                .resizable()
                .ignoresSafeArea(.all)

            VStack(spacing: 0) {
                Spacer()

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

                Spacer()
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
            largeExhibitButton
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    smallExhibitButton
                    
                    ForEach(viewModel.images, id: \.self) { imgURL in
                        ExhibitedImageCell(imageURL: imgURL,
                                           heartCount: 333,
                                           commentCount: 333) { width in
                            contentWidth += width + 16
                        }
                    }
                }
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                DispatchQueue.main.async {
                                    contentWidth = geometry.size.width
                                }
                            }
                    }
                )
                .frame(
                    width: max(contentWidth, Constants.screenWidth),
                    alignment: contentWidth < Constants.screenWidth * 0.9 ? .center : .leading
                )
                .padding(.horizontal, contentWidth > Constants.screenWidth * 0.9 ? 20 : 0)
            }
        }
    }

    private var largeExhibitButton: some View {
        Button {
            // TODO: - 출품하기
        } label: {
            ZStack {
                Rectangle()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: Constants.screenWidth * (257/393))
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
    }

    private var smallExhibitButton: some View {
        Button {
            // TODO: - 출품하기
        } label: {
            Group {
                Image(viewModel.exhibitedCount < 3 ? "icPlus" : "icPlusWhite")
                    .resizable()
                    .frame(width: 28, height: 28)
            }
            .frame(width: 60)
            .frame(height: Constants.screenHeight * (257/852))
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
        .disabled(viewModel.exhibitedCount == 3)
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
            .shadow(color: .black.opacity(0.25),
                    radius: 4,
                    x: 2,
                    y: 2)
        }
        .padding(.horizontal, 32)
    }
}

#Preview {
    ContestOutlineView()
}

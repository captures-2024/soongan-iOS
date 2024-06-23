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
                exhibitButtonView
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

    private var exhibitButtonView: some View {
        Button {
            // TODO: - 출품 로직
        } label: {
            ZStack {
                Rectangle()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: Constants.screenWidth - 136)
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

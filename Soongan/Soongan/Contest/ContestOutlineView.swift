//
//  ContestOutlineView.swift
//  Soongan
//
//  Created by 김민 on 6/16/24.
//

import SwiftUI

enum ContestMode: String, CaseIterable {
    case weekly
    case daily
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

            VStack(spacing: 28) {
                HStack {
                    Image("soonganLogo")
                    Spacer()
                    ContestModeSegmentedControl(selection: $contestMode)
                }
                .padding(.top, 16)

                Spacer()

                HStack {
                    Text("평화")
                        .font(.system(size: 32))
                    Spacer()
                }
                .padding(.bottom, 20)

                HStack {
                    Spacer()
                        .frame(width: 80)
                    Text("""
                    “평화를 찾기 위해 인도나 그 어디에도 갈 필요가 없습니다. 당신은 당신의 방, 정원, 심지어 욕조에서도 바로 그 깊은 침묵의 장소를 발견할 수 있을 것입니다.”
                    """)
                    .font(.system(size: 16))
                }
                .padding(.bottom, 40)

                HStack {
                    Spacer()
                    Text("05.14 - 05.21")
                        .font(.system(size: 20))
                }

                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("리워드 :  리워드는 어떻게?")
                        Text("선정방식 :  선정방식은 어떻게?")
                    }
                    .font(.system(size: 14))
                    Spacer()
                }
                .padding(.bottom, 38)

                HStack {
                    VStack(alignment: .trailing, spacing: 4) {
                        Image("leftArrow")
                        Text("참여하기")
                    }
                    .padding(.leading, -12)

                    Spacer()

                    VStack(alignment: .leading, spacing: 4) {
                        Image("rightArrow")
                        Text("갤러리로")
                    }
                    .padding(.trailing, 4)
                }
                .font(.system(size: 12))

                Spacer()
            }
            .padding(.leading, 32)
            .padding(.trailing, 16)
        }
    }
}

struct ContestModeSegmentedControl: View {
    @Binding var selection: ContestMode

    var body: some View {
        HStack(spacing: 0) {
            ForEach(ContestMode.allCases, id: \.self) { mode in
                ZStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundColor(selection == mode ? .black : Color.clear)
                        Text(mode.rawValue)
                            .foregroundColor(selection == mode ? .white : Color.init(hex: 0xC3C3C3))
                            .font(.system(size: 14))
                    }
                    .onTapGesture {
                        selection = mode
                    }
                }
            }
        }
        .frame(width: 132, height: 32)
        .background {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.shadow(.inner(color: Color(hex: 0xFAF9F5, alpha: 0.3),
                                               radius: 2,
                                               x: 1,
                                               y: 1)))
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.shadow(.inner(color: Color(hex: 0xCCCBC9, alpha: 0.5),
                                               radius: 2,
                                               x: -1,
                                               y: -1)))
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.shadow(.drop(color: Color(hex: 0xCCCBC9, alpha: 0.2),
                                              radius: 10,
                                              x: -5,
                                              y: 5)))
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.shadow(.drop(color: Color(hex: 0xCCCBC9, alpha: 0.2),
                                              radius: 10,
                                              x: 5,
                                              y: -5)))
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.shadow(.drop(color: Color(hex: 0xFAF9F5, alpha: 0.9),
                                              radius: 10,
                                              x: -5,
                                              y: -5)))
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white.shadow(.drop(color: Color(hex: 0xCCCBC9, alpha: 0.9),
                                              radius: 13,
                                              x: 5,
                                              y: 5)))
            }
        }
    }
}

#Preview {
    ContestOutlineView()
}

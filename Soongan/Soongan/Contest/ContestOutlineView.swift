//
//  ContestOutlineView.swift
//  Soongan
//
//  Created by 김민 on 6/9/24.
//

import SwiftUI

enum ContestMode {
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

            VStack(spacing: 48) {
                HStack {
                    Image("soonganLogo")
                    Spacer()
                    pickerView
                }

                Spacer()
                HStack {
                    Text("평화")
                        .font(.system(size: 32))
                    Spacer()
                }
                HStack {
                    Spacer()
                        .frame(width: 80)
                    Text("""
                    “평화를 찾기 위해 인도나 그 어디에도 갈 필요가 없습니다. 당신은 당신의 방, 정원, 심지어 욕조에서도 바로 그 깊은 침묵의 장소를 발견할 수 있을 것입니다.”
                    """)
                    .font(.system(size: 16))
                }

                HStack {
                    Spacer()
                    Text("05.14 - 05.21")
                        .font(.system(size: 20))
                }

                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("리워드 :  리워드는 어떻게?")
                            .font(.system(size: 14))
                        Text("선정방식 :  선정방식은 어떻게?")
                            .font(.system(size: 14))
                    }
                    Spacer()
                }

                Spacer()
            }
            .padding(.leading, 32)
            .padding(.trailing, 16)
        }
    }

    private var pickerView: some View {
        Picker("Contest Mode", selection: $contestMode) {
            Text("weekly")
                .tag(ContestMode.weekly)
            Text("daily")
                .tag(ContestMode.daily)
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    ContestOutlineView()
}


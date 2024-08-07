//
//  ReportCasesView.swift
//  Soongan
//
//  Created by 김민 on 8/6/24.
//

import SwiftUI

enum ReportCases: CaseIterable {
    case inappropriate
    case offensive
    case infringe
    case spam
    case promotionalContent
    case other

    var title: String {
        switch self {
        case .inappropriate:
            return "부적절한 사진 게시 및 언행"
        case .offensive:
            return "욕설, 혐오, 비하 등이 포함된 표현"
        case .infringe:
            return "도용, 초상권, 저작권 등 타인의 권리 침해"
        case .spam:
            return "도배"
        case .promotionalContent:
            return "홍보용 사진 혹은 댓글 게시"
        case .other:
            return "기타"
        }
    }
}

struct ReportCasesView: View {

    var body: some View {
        VStack(spacing: 0) {
            ModalHandler()
                .padding(.bottom, 10)

            Text("신고")
                .font(.system(size: 16, weight: .bold))
                .padding(.bottom, 8)

            Divider()
                .padding(.bottom, 16)

            ForEach(ReportCases.allCases.indices, id: \.self) { idx in
                Group {
                    reportCaseView(title: ReportCases.allCases[idx].title)

                    if idx < ReportCases.allCases.count - 1 {
                        Divider()
                            .background(Color.primaryA.opacity(0.3))
                    }
                }
                .padding(.horizontal, 24)
                .onTapGesture {
                    // TODO: 모달 이동
                }
            }
        }
    }

    private func reportCaseView(title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.leading, 16)
    }
}

#Preview {
    ReportCasesView()
}

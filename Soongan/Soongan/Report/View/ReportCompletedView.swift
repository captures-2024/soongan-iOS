//
//  ReportCompletedView.swift
//  Soongan
//
//  Created by 김민 on 8/6/24.
//

import SwiftUI

struct ReportCompletedView: View {

    var body: some View {
        VStack(spacing: 0) {
            ModalHandler()
                .padding(.bottom, 10)

            Text("신고")
                .font(.system(size: 16, weight: .bold))
                .padding(.bottom, 8)

            Divider()

            Text("""
            신고가 완료됐습니다.

            해당 게시물은 숨김처리되었습니다.

            3일 이내로 검토 후 조치가 이뤄질 예정입니다. 
            결과가 나오면 알림으로 알려드리겠습니다.
            감사합니다.
            """)
            .font(.system(size: 16, weight: .bold))
            .padding(.top, 40)
            .padding(.bottom, 48)

            BlackButton(title: "확인") {
                // TODO: NavigationStack pop
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    ReportCompletedView()
}

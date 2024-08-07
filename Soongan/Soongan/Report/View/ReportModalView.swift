//
//  ReportModalView.swift
//  Soongan
//
//  Created by 김민 on 8/7/24.
//

import SwiftUI

enum ReportViewType: Equatable {
    case reportCase
    case submitReport(reportCase: ReportCases)
    case reportCompleted
    case none
    case completed
}

struct ReportModalView<Content>: View where Content: View {

    @Binding var mode: ReportViewType
    var content: () -> Content

    var height: CGFloat {
        switch mode {
        case .reportCase:
            return 428
        case .submitReport:
            return 239
        case .reportCompleted:
            return 383
        case .none, .completed:
            return 0
        }
    }

    var body: some View {
        VStack {
            Spacer()
            content()
                .cornerRadius(20)
                .frame(maxWidth: .infinity, maxHeight: height)
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.linear, value: mode)
                .animation(.easeInOut(duration: 0.2), value: mode)
        }
    }
}

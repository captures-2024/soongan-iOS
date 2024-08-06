//
//  ReportViewType.swift
//  Soongan
//
//  Created by 김민 on 8/6/24.
//

import Foundation

enum ReportViewType: String, Identifiable {
    case reportCase
    case submitReport
    case reportCompleted

    var id: String {
        return self.rawValue
    }
}

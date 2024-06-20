//
//  MainTabType.swift
//  Soongan
//
//  Created by 김민 on 6/20/24.
//

import Foundation

enum MainTabType: String, CaseIterable {
    case home
    case gallery
    case award
    case my

    func imageName(selected: Bool) -> String {
        selected ? "\(rawValue)Selected" : rawValue
    }
}

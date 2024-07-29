//
//  ContestOutlineViewModel.swift
//  Soongan
//
//  Created by 김민 on 6/25/24.
//

import Foundation

class ContestOutlineViewModel: ObservableObject {
    
    @Published var exhibitedCount: Int = 3
    @Published var images: [String] = []

    init() {
        images = [
            "https://picsum.photos/500/300",
            "https://picsum.photos/200/400",
            "https://picsum.photos/300/400"
        ]
    }
}

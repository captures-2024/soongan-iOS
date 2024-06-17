//
//  SignUpMainViewModel.swift
//  Soongan
//
//  Created by juni on 6/17/24.
//

import Foundation

class SignUpMainViewModel: ObservableObject {
    struct State {
    
    }
    
    enum Action {
        // API 통신
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    func action(_ action: Action) async {
        // API 통신
    }
    
}

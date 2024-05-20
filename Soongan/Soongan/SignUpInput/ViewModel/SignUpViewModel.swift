//
//  SignUpViewModel.swift
//  Soongan
//
//  Created by 김민 on 5/17/24.
//

import Foundation
import Combine

class SignUpViewModel: ObservableObject {
    @Published var nickname = ""
    @Published var year = ""

    @Published var nicknameMessage = ""
    @Published var yearMessage = ""
    @Published var isNicknameValid = false
    @Published var isYearValid = false

    private var cancellables: Set<AnyCancellable> = []

    var isYearValidPublisher: AnyPublisher<Bool, Never> {
        $year
            .compactMap { Int($0) }
            .map {
                return $0 >= 1950 && $0 <= 2009
            }
            .eraseToAnyPublisher()
    }

    init() {
        isYearValidPublisher
            .receive(on: DispatchQueue.main)
            .map { [weak self] valid in
                self?.isYearValid = valid
                return valid ? "출생연도 숫자 4자리를 기입해주세요." : "1950-2009 이내의 기간을 입력해주세요."
            }
            .assign(to: \.yearMessage, on: self)
            .store(in: &cancellables)
    }
}



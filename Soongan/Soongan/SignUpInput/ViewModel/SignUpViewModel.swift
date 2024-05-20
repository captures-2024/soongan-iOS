//
//  SignUpViewModel.swift
//  Soongan
//
//  Created by 김민 on 5/17/24.
//

import Foundation
import Combine

enum ValidationCheck {
    case empty, invalid, valid
}

class SignUpViewModel: ObservableObject {
    @Published var nickname = ""
    @Published var year = ""

    @Published var nicknameMessage = ""
    @Published var yearMessage = ""

    @Published var isNextButtonEnabled = false
    @Published var isNicknameValid = ValidationCheck.empty
    @Published var isYearValid = ValidationCheck.empty

    private var cancellables: Set<AnyCancellable> = []

    var isYearValidPublisher: AnyPublisher<ValidationCheck, Never> {
        $year
            .map { year -> ValidationCheck in
                if year.isEmpty {
                    return .empty
                } else if let year = Int(year), year >= 1950 && year <= 2009 {
                    return .valid
                } else {
                    return .invalid
                }
            }
            .eraseToAnyPublisher()
    }

    var isNicknameLengthValidPublisher: AnyPublisher<Bool, Never> {
        $nickname
            .map {
                return $0.count >= 3 && $0.count <= 10
            }
            .eraseToAnyPublisher()
    }

    init() {
        setNicknameValidation()
        setYearValidation()
    }

    func setNicknameValidation() {
        isNicknameLengthValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isNextButtonEnabled, on: self)
            .store(in: &cancellables)
    }

    func setYearValidation() {
        isYearValidPublisher
            .receive(on: DispatchQueue.main)
            .map { yearCheck -> String in
                switch yearCheck {
                case .invalid:
                    return "1950-2009 이내의 기간을 입력해주세요."
                default:
                    return "출생연도 숫자 4자리를 기입해주세요."
                }
            }
            .assign(to: \.yearMessage, on: self)
            .store(in: &cancellables)

        isYearValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.isYearValid, on: self)
            .store(in: &cancellables)
    }
}



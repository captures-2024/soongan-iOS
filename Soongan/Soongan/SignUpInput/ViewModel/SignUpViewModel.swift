//
//  SignUpViewModel.swift
//  Soongan
//
//  Created by 김민 on 5/17/24.
//

import Foundation
import Combine

enum ValidationCheck {
    case normal, invalid, valid, lengthValid
}

class SignUpViewModel: ObservableObject {

    struct State {
        var isNextButtonEnabled = false
        var isNicknameValid = ValidationCheck.normal
        var isYearValid = ValidationCheck.normal
        var nicknameMessage = ""
        var yearMessage = ""
    }

    enum Action {
        case checkNickname
    }

    @Published var state: State
    @Published var nickname = ""
    @Published var year = ""
    @Published var isDuplicated: Bool?

    private var cancellables: Set<AnyCancellable> = []

    init(
        state: State = .init()
    ) {
        self.state = state
        bind()
    }

    private func bind() {
        $nickname
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .map { _ in "3-10자리 숫자, 영문, 한글로 기입해주세요" }
            .assign(to: \.state.nicknameMessage, on: self)
            .store(in: &cancellables)

        $nickname
            .receive(on: DispatchQueue.main)
            .map { nickname -> ValidationCheck in
                return nickname.count >= 3 && nickname.count <= 10 ? .lengthValid : .normal
            }
            .handleEvents(receiveOutput: { [weak self] validation in
                self?.state.isNicknameValid = validation
            })
            .map { $0 == .lengthValid }
            .assign(to: \.state.isNextButtonEnabled, on: self)
            .store(in: &cancellables)

        $isDuplicated
             .receive(on: DispatchQueue.main)
             .compactMap { $0 }
             .sink { [weak self] isDuplicated in
                 guard let self = self else { return }

                 if isDuplicated == false {
                     state.nicknameMessage = "아이디가 중복되었습니다."
                     state.isNextButtonEnabled = false
                     state.isNicknameValid = .invalid
                 } else {
                     state.isNicknameValid = .valid
                 }
             }
             .store(in: &cancellables)

        $year
            .map { [weak self] year -> ValidationCheck in
                guard let self = self else { return .invalid }
                return validateYear(year)
            }
            .map { validation in
                self.state.isYearValid = validation
                return self.yearValidationMessage(for: validation)
            }
            .assign(to: \.state.yearMessage, on: self)
            .store(in: &cancellables)

    }

    @MainActor
    func action(_ action: Action) async {
        switch action {
        case .checkNickname:
            if containsSpecialCharacters(nickname) {
                state.nicknameMessage = "특수문자는 제거해주세요"
                state.isNextButtonEnabled = false
                state.isNicknameValid = .invalid
                return
            }

            guard let response = await UserService.checkNicknameValidation(parameter: nickname) else {
                return
            }

            isDuplicated = response.responseData ?? false
        }
    }

    private func containsSpecialCharacters(_ text: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[!@#$%^&*()\\-=+\\[\\]]", options: [])
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }

    private func validateYear(_ year: String) -> ValidationCheck {
        if year.isEmpty {
            return .normal
        } else if let yearInt = Int(year), yearInt >= 1950 && yearInt <= 2009 {
            return .valid
        } else {
            return .invalid
        }
    }

    private func yearValidationMessage(for validation: ValidationCheck) -> String {
        switch validation {
        case .invalid:
            return "1950-2009 이내의 기간을 입력해주세요."
        default:
            return "출생연도 숫자 4자리를 기입해주세요."
        }
    }
}



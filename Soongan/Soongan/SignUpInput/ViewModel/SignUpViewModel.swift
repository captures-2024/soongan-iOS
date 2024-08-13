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

    enum Action {
        case checkNickname
    }

    @Published var nickname = ""
    @Published var year = ""
    @Published var nicknameMessage = ""
    @Published var yearMessage = ""
    @Published var isNextButtonEnabled = false
    @Published var isNicknameValid = ValidationCheck.normal
    @Published var isYearValid = ValidationCheck.normal
    @Published var isDuplicated: Bool?

    private var cancellables: Set<AnyCancellable> = []

    var isYearValidPublisher: AnyPublisher<ValidationCheck, Never> {
        $year
            .map { year -> ValidationCheck in
                if year.isEmpty {
                    return .normal
                } else if let year = Int(year), year >= 1950 && year <= 2009 {
                    return .valid
                } else {
                    return .invalid
                }
            }
            .eraseToAnyPublisher()
    }

    init() {
        setYearValidation()

        bind()
    }

    private func bind() {
        $nickname
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .map { _ in "3-10자리 숫자, 영문, 한글로 기입해주세요" }
            .assign(to: \.nicknameMessage, on: self)
            .store(in: &cancellables)

        $nickname
            .receive(on: DispatchQueue.main)
            .map { nickname -> ValidationCheck in
                return nickname.count >= 3 && nickname.count <= 10 ? .lengthValid : .normal
            }
            .handleEvents(receiveOutput: { [weak self] validation in
                self?.isNicknameValid = validation
            })
            .map { $0 == .lengthValid }
            .assign(to: \.isNextButtonEnabled, on: self)
            .store(in: &cancellables)

        $isDuplicated
             .receive(on: DispatchQueue.main)
             .compactMap { $0 }
             .sink { [weak self] isDuplicated in
                 guard let self = self else { return }

                 if isDuplicated {
                     nicknameMessage = "아이디가 중복되었습니다."
                     isNextButtonEnabled = false
                     isNicknameValid = .invalid
                 } else {
                     isNicknameValid = .valid
                 }
             }
             .store(in: &cancellables)

    }

    @MainActor
    func action(_ action: Action) async {
        switch action {
        case .checkNickname:
            if containsSpecialCharacters(nickname) {
                nicknameMessage = "특수문자는 제거해주세요"
                isNextButtonEnabled = false
                isNicknameValid = .invalid
                return
            }

            // TODO: 수정
            isDuplicated = false
            isNicknameValid = .valid

//            guard let response = await UserService.checkNicknameValidation(parameter: nickname) else {
//                return
//            }
//
//            isDuplicated = response.data ?? false
        }
    }

    private func setYearValidation() {
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

    private func containsSpecialCharacters(_ text: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "[!@#$%^&*()\\-=+\\[\\]]", options: [])
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex.firstMatch(in: text, options: [], range: range) != nil
    }
}



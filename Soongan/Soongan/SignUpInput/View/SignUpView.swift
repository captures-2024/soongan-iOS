//
//  SignUpView.swift
//  Soongan
//
//  Created by 김민 on 5/16/24.
//

import SwiftUI

enum FocusField: Hashable {
    case nickname
    case year
}

struct SignUpView: View {
    @FocusState private var focusedField: FocusField?
    
    @Environment(\.dismiss) var dismiss

    @StateObject var viewModel = SignUpViewModel()

    var body: some View {
        ZStack {
            Color.primaryA
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    backButton
                    Spacer()
                }
                .padding(.leading, -24)
                .padding(.top, 20)

                Spacer()

                if viewModel.isNicknameValid != .valid  {
                    nicknameTextField
                    Spacer()
                    nextButton
                        .padding(.bottom, 20)
                } else {
                    nicknameLabel
                        .padding(.leading, 16)
                    Spacer()
                    yearTextField
                    Spacer()
                    completeButton
                        .padding(.bottom, 20)
                }
            }
            .padding(.horizontal, 40)
        }
        .onAppear {
            focusedField = .nickname
        }
        .toolbar(.hidden)
    }

    private var nicknameTextField: some View {
        VStack(spacing: 12) {
            SignUpTextFieldView(fieldName: "닉네임",
                                placeholder: "사용자명을 입력해주세요.",
                                text: $viewModel.nickname,
                                validation: viewModel.isNicknameValid)
                .focused($focusedField, equals: .nickname)
            HStack {
                Text(viewModel.nicknameMessage)
                    .foregroundStyle(viewModel.isNicknameValid == .invalid ? Color.negative : Color(hex: 0xCACACA))
                Spacer()
                Text("\(viewModel.nickname.count)/10")
                    .foregroundStyle(Color(hex: 0xCACACA))
            }
            .font(.system(size: 12))
            .padding(.horizontal, 12)
        }
    }

    private var yearTextField: some View {
        VStack(spacing: 12) {
            SignUpTextFieldView(fieldName: "출생연도",
                                placeholder: "YYYY",
                                text: $viewModel.year,
                                validation: viewModel.isYearValid)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .year)
            HStack {
                Text(viewModel.yearMessage)
                Spacer()
            }
            .font(.system(size: 12))
            .foregroundStyle(viewModel.isYearValid == .invalid ? Color.negative : Color(hex: 0xCACACA))

            .padding(.horizontal, 12)
        }
    }

    private var backButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                Text("회원가입")
            }
        })
        .font(.system(size: 24))
        .foregroundStyle(Color.primaryB)
    }


    private var nextButton: some View {
        Button(action: {
            focusedField = .year
            Task {
                await viewModel.action(.checkNickname)
            }
            // 닉네임 정보 저장
            AppState.shared.nickName = viewModel.nickname
      
        }, label: {
            VStack(spacing: 12) {
                Text("다음이 마지막 단계입니다!")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: 0xCACACA))
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.primaryB)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(viewModel.isNextButtonEnabled ? Color.positive : Color.gray300)
                    .cornerRadius(8)
            }
        })
        .disabled(!viewModel.isNextButtonEnabled)
    }

    private var completeButton: some View {
        Button(action: {
            // TODO: next view
            AppState.shared.navigationPath.append(SignUpViewType.final)
        }, label: {
            VStack(spacing: 12) {
                Text("마지막 단계입니다!")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: 0xCACACA))
                Text("완료")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.primaryB)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(viewModel.isYearValid == .valid ? Color.positive : Color.gray300)
                    .cornerRadius(8)
            }
        })
        .disabled(viewModel.isYearValid != .valid)
        .navigationDestination(for: SignUpViewType.self) { viewType in
            switch viewType {
            case .final:
                SignUpFinishView()
            }
        }
    }

    private var nicknameLabel: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("닉네임")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: 0xCACACA))
                Text(viewModel.nickname)
                    .font(.system(size: 18))
                    .foregroundStyle(Color.primaryB)
            }
            Spacer()
        }
    }
}

enum SignUpViewType {
    case final
}

struct SignUpTextFieldView: View {
    var fieldName: String
    var placeholder: String
    @Binding var text: String
    var validation: ValidationCheck

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(fieldName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.primaryB)
                Spacer()
            }
            .padding(.bottom, 4)
            .padding(.leading, 12)
            ZStack(alignment: .trailing) {
                TextField(placeholder, text: $text)
                    .tint(Color.primaryA)
                    .font(.system(size: 18, weight: .medium))
                    .padding(.horizontal, 12)
                    .frame(height: 48)
                    .background(.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.negative, lineWidth: validation == .invalid ? 2 : 0)
                    )

                Group {
                    switch validation {
                    case .normal:
                        Image("imgCheckCircle")
                    case .invalid:
                        Image("imgXmarkCircle")
                            .foregroundStyle(Color.negative)
                    default:
                        Image("imgCheckCircleValid")
                            .foregroundStyle(Color.positive)
                    }
                }
                .padding(.trailing, 12)
            }
        }
    }
}

#Preview {
    SignUpView()
}

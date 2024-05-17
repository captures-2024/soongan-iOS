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
    @State private var isNicknameValid = false

    @StateObject var viewModel = SignUpViewModel()

    var body: some View {
        ZStack {
            Color(hex: 0x252525)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    backButton
                    Spacer()
                }
                .padding(.leading, -24)
                .padding(.top, 20)

                Spacer()

                if !isNicknameValid {
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
    }

    private var nicknameTextField: some View {
        VStack(spacing: 12) {
            SignUpTextFieldView(fieldName: "닉네임",
                                placeholder: "사용자명을 입력해주세요.",
                                text: $viewModel.nickname)
                .focused($focusedField, equals: .nickname)
            HStack {
                Text("3-10자리 숫자, 영문, 한글로 기입해주세요")
                Spacer()
                Text("\(viewModel.nickname.count)/10")
            }
            .font(.system(size: 12))
            .foregroundStyle(Color(hex: 0xCACACA))
            .padding(.horizontal, 12)
        }
    }

    private var yearTextField: some View {
        VStack(spacing: 12) {
            SignUpTextFieldView(fieldName: "출생연도",
                                placeholder: "YYYY",
                                text: $viewModel.year)
            .keyboardType(.numberPad)
            .focused($focusedField, equals: .year)
            HStack {
                Text("출생연도 숫자 4자리를 기입해주세요.")
                Spacer()
            }
            .font(.system(size: 12))
            .foregroundStyle(Color(hex: 0xCACACA))
            .padding(.horizontal, 12)
        }
    }

    private var backButton: some View {
        Button(action: {}, label: {
            HStack(spacing: 16) {
                Image(systemName: "chevron.left")
                Text("회원가입")
            }
        })
        .font(.system(size: 24))
        .foregroundStyle(Color(hex: 0xF5F5F5))
    }


    private var nextButton: some View {
        Button(action: {
            isNicknameValid = true
            focusedField = .year
        }, label: {
            VStack(spacing: 12) {
                Text("다음이 마지막 단계입니다!")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: 0xCACACA))
                Text("다음")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color(hex: 0xF5F5F5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(hex: 0x276EF1))
                    .cornerRadius(8)
            }
        })
    }

    private var completeButton: some View {
        Button(action: {
            // TODO: next view
        }, label: {
            VStack(spacing: 12) {
                Text("마지막 단계입니다!")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: 0xCACACA))
                Text("완료")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color(hex: 0xF5F5F5))
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(Color(hex: 0x276EF1))
                    .cornerRadius(8)
            }
        })
    }

    private var nicknameLabel: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("닉네임")
                    .font(.system(size: 12))
                    .foregroundStyle(Color(hex: 0xCACACA))
                Text(viewModel.nickname)
                    .font(.system(size: 18))
                    .foregroundStyle(Color(hex: 0xF5F5F5))
            }
            Spacer()
        }
    }
}

struct SignUpTextFieldView: View {
    var fieldName: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(fieldName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color(hex: 0xF5F5F5))
                Spacer()
            }
            .padding(.bottom, 4)
            .padding(.leading, 12)
            TextField(placeholder, text: $text)
                .tint(Color(hex: 0x252525))
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal, 12)
                .frame(height: 48)
                .background(.white)
                .cornerRadius(8)
        }
    }

}

#Preview {
    SignUpView()
}

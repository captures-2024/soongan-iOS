//
//  CapturesNavigationBar.swift
//  Soongan
//
//  Created by juni on 6/12/24.
//

import SwiftUI

struct CapturesNavigationBar: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 0) {
            Button {
                dismiss()
            } label: {
                HStack(spacing: 0) {
                    Image("icLeft")
                        .frame(width: 44, height: 44)
                        .background(Color(hex: 0xEBEBEB))
                        .clipShape(Circle())
                    
                        .shadow(radius: 10)
                        .padding(.leading, 20)
            
                }
                
            }

        }
    }
}

#Preview {
    CapturesNavigationBar()
}

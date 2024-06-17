//
//  GalleryView.swift
//  Soongan
//
//  Created by juni on 6/12/24.
//

import SwiftUI


struct ColumnModel: Identifiable {
    var id = UUID()
    // A description of a row or a column in a lazy grid.
    var item: GridItem
    
    // columns 을 2개로 설정
    static let columns: [ColumnModel] = [
        ColumnModel(item: GridItem()),
        ColumnModel(item: GridItem())
    ]
}

struct GalleryView: View {
   
    var body: some View {
        let numbers: [Int] = Array(1...100)
        
        VStack(spacing: 0) {
            ZStack() {
                Image("galleryBackground")
                    .resizable()
                    .frame(width: Constants.screenWidth, height: Constants.screenHeight)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    ZStack {
                        HStack(spacing: 0){
                            CapturesNavigationBar()
                            Spacer()
                        }
                        Text("W _ 1회차 | 평화")
                            .font(.system(size: 24, weight: .medium))
                    }
                    .padding(.bottom, 36)
                  
                        ScrollViewReader { scrollViewProxy in
                            ZStack() {
                                ScrollView(.vertical) {
                                    HStack(alignment: .top, spacing: 5) {
                                        ForEach(ColumnModel.columns) { _ in
                                            VStack {
                                                ForEach(numbers, id: \.self) { item in
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .frame(width: 200, height: Bool.random() ? 200 : 300)
                                                        .foregroundStyle(Color.init(hex: 0xD9D9D9))
                                                }
                                            }
                                            .id("scrollToTop")
                                        }
                                    }
                                }
                                .edgesIgnoringSafeArea(.bottom)
                                VStack(spacing: 0) {
                                    Spacer()
                                    HStack(spacing: 0) {
                                        Spacer()
                                        Button(action: {
                                            withAnimation {
                                                scrollViewProxy.scrollTo("scrollToTop", anchor: .top)
                                            }
                                            
                                        }, label: {
                                            Image("icUp")
                                                .frame(width: 44, height: 44)
                                                .background(Color(hex: 0xEBEBEB))
                                                .clipShape(Circle())
                                            
                                                .shadow(radius: 10)
                                                .padding(.leading, 20)
                                        })
                                        .padding(.trailing, 20)
                                    }
                                    .padding(.bottom, 54)
                                }
                                
                            }
                        }
                }
                .padding(.top, 48)
            }
        }
    }
}

#Preview {
    GalleryView()
}

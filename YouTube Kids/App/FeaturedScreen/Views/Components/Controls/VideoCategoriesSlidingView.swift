//
//  VideoCategoriesSlidingView.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import SwiftUI

struct VideoCategoriesSlidingView: View {
    let categories: [CategoryEntity]
    @State var selectedCategory: String = ""
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Spacer()
                ForEach(categories, id: \.id) { category in
                    let isHighlighted = category.id == selectedCategory
                    Button {
                        selectedCategory = category.id
                        print(category.id)
                    } label: {
                        Text(category.title)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(isHighlighted ? Color.blue : Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                    }
                }
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
    }
}

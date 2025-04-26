//
//  CollectionView.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/26/25.
//

import SwiftUI

struct CollectionView<Cell: View, Content: Identifiable>: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let content: [Content]
    @ViewBuilder let cell: (Content) -> Cell
    
    var body: some View {
        switch horizontalSizeClass {
            case .compact:
                List(content) { item in
                    cell(item)
                }
            default:
                ScrollView {
                    LazyVGrid(
                        columns: [
                            .init(
                                .adaptive(minimum: 240, maximum: 400)
                            )
                        ]
                    ) {
                        ForEach(content) { item in
                            cell(item)
                                .padding(.horizontal)
                        }
                    }
                }
        }
    }
}

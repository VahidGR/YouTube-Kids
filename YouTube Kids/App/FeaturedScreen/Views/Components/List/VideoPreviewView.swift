//
//  VideoPreviewView.swift
//  YouTube Kids
//
//  Created by Vahid Ghanbarpour on 4/22/25.
//

import SwiftUI

struct VideoPreviewView: View {
    let model: VideoPreviewModelProtocol
    var body: some View {
        VStack {
            Header(model: model)
                .clipShape(RoundedRectangle(cornerRadius: 4))
            Footer(model: model)
        }
    }
    
    struct Header: View {
        let model: VideoPreviewModelProtocol
        var body: some View {
            /*
            Image(systemName: "platter.2.filled.ipad.landscape")
                .resizable()
                .aspectRatio(2, contentMode: .fit)
            */
            Color.green
                .aspectRatio(1.7777777778, contentMode: .fit)
                .overlay {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text(model.length)
                                .padding(6)
                                .font(.caption)
                                .foregroundStyle(.white)
                                .background(Color.black.opacity(0.4))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .padding(8)
                        }
                    }
                }
        }
    }
    
    struct Footer: View {
        let model: VideoPreviewModelProtocol
        var body: some View {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 32)
                    .clipShape(Circle())
                VStack {
                    HStack {
                        Text(model.headline)
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text(model.subheadline)
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                        Spacer()
                    }
                }
                
                Button {
                    Task {
                        await model.save()
                    }
                } label: {
                    Image(systemName: model.saveIcon)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 24)
                }
                .buttonStyle(.plain)
                .onAppear(perform: model.updateState)
            }
        }
    }
}

//
//  CatDetailsView.swift
//  cats-app
//
//  Created by Edson Brandon on 03/06/25.
//

import SwiftUI

struct CatDetailsView: View {
    var viewModel: CatDetailsViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                AsyncImage(url: URL(string:  "https://cataas.com/cat/" + viewModel.cat.id)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(maxWidth: .infinity, minHeight: 200)
                            .background(Color.gray.opacity(0.2))
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: geometry.size.height * 0.4)
                            .clipped()
                            .frame(maxWidth: .infinity)
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, minHeight: 250)
                            .background(Color.gray.opacity(0.1))
                    @unknown default:
                        EmptyView()
                    }
                }
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.cat.id)
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding(.top, 5)
                    HStack {
                        ForEach(viewModel.cat.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.caption)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Capsule().fill(Color.blue.opacity(0.15)))
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }
                    .padding(.vertical, 2)
                    
                    Text("Created At: \(viewModel.cat.createdAt)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)
        }
    }

}

// MARK: - Preview Provider

#Preview {

    let mockCat = Cat(
        id: "abc-123-xyz",
        tags: ["black", "cute", "funny"],
        createdAt: "21/12/2000"
    )
    
    let mockViewModel = CatDetailsViewModel(cat: mockCat)
    
    NavigationView {
        CatDetailsView(viewModel: mockViewModel)
    }
   
}

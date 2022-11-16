//
//  CatFeedView.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import SwiftUI

struct CatFeedView: View {
    @StateObject var viewModel = CatFeedViewModel()
    @State var skip: Int = 0

    var limit: Int = 50

    var body: some View {
        return NavigationView {
            VStack {
                // Show loading spinner that covers screen on intial load when there are no cats
                if viewModel.isLoading && viewModel.cats.isEmpty {
                    ProgressView()
                } else {
                    gridView()
                }
            }.onAppear {
                // Fetch cats when the view appears
                viewModel.isLoading = true
                Task {
                    await viewModel.getCats(skip: skip, limit: limit)
                }
            }
            .navigationTitle(Strings.CatFeed.navTitleCatFeed)
        }
    }

    func gridView() -> some View {
        let columns = [GridItem(.adaptive(minimum: 100, maximum: .infinity), spacing: 3)]

        return ScrollView {
            LazyVGrid(columns: columns, spacing: 3) {
                ForEach(viewModel.cats, id: \.id) { cat in
                    CatFeedItemView(cat: cat)
                        .onAppear {
                            // When we scroll to the last cat in the grid, fetch more cats
                            if cat.id == viewModel.cats.last?.id {
                                skip += limit
                                Task {
                                    await viewModel.getCats(skip: skip, limit: limit)
                                }
                            }
                        }
                }

                // Show a loading spinner at the last item in the grid when we're fetching more cats
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }.frame(maxWidth: .infinity)
    }
}

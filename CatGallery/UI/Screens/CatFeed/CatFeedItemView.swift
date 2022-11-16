//
//  CatFeedItemView.swift
//  CatGallery
//
//  Created by Obiora Anachebe on 11/15/22.
//

import Foundation
import SwiftUI
import NukeUI
import Nuke

struct CatFeedItemView: View {
    var cat: CatModel

    var body: some View {
        // Use a GeometryReader to get the size of the item and fetch
        // a cat photo to fill that size
        return GeometryReader { geometry in
            let pipeline = ImagePipeline {
                $0.isProgressiveDecodingEnabled = true
            }
            let request = getImageRequest(for: geometry.size)

            LazyImage(request: request)
                .pipeline(pipeline)
                .scaledToFill()
                .frame(height: geometry.size.width)

        }
        .clipped()
        .aspectRatio(1, contentMode: .fit)
    }

    func getImageRequest(for size: CGSize) -> ImageRequest {
        let widthPx = Int(size.width * UIScreen.main.scale)
        let heightPx = Int(size.height * UIScreen.main.scale)

        let pipeline = ImagePipeline {
            $0.isProgressiveDecodingEnabled = true
        }

        var processors: [ImageProcessing] = []
        if size != .zero {
            processors.append(ImageProcessors.Resize(size: size))
        }

        let url = cat.getImageUrl(
            width: widthPx,
            height: heightPx
        )

        return  ImageRequest(
            url: url,
            processors: processors
        )
    }
}

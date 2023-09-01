//
//  VideoView.swift
//  ValU
//
//  Created by Wahab  on 2021-09-16.
//

import SwiftUI
import WebKit
import youtube_ios_player_helper

struct VideoView: UIViewRepresentable {
    let videoID: String

    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }

    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
}

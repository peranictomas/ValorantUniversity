//
//  TutorialView.swift
//  ValU
//
//  Created by Wahab  on 2021-09-19.
//

import SwiftUI

struct TutorialView: View {
    @Binding var videoID: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            VideoView(videoID: videoID)
                .frame(minHeight: 0, maxHeight: UIScreen.main.bounds.height * 0.3)
                .cornerRadius(12)
                .padding(.horizontal, 24)
        }
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView(videoID: .constant("FoYc1wMLNf0"))
    }
}

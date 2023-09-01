//
//  TextFieldView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-23.
//

import SwiftUI

struct TextFieldView: View {
    var placeHolder: String
    @Binding var txt: String

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            ZStack {
                if placeHolder == "Password" || placeHolder == "Confirm Password" {
                    SecureField(placeHolder, text: $txt)
                } else {
                    TextField(placeHolder, text: $txt)
                }
            }

            .padding(.horizontal)
            .padding(.leading, 10)
            .frame(height: 60)
            .background(Color.white.opacity(0.2))
            .clipShape(Capsule())
        }
        .padding(.horizontal)
    }
}

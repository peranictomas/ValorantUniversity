//
//  HomeCardItemView.swift
//  ValU
//
//  Created by Rayan Syed on 2021-10-11.
//

import SwiftUI

struct HomeSheetView: View {
    var image: String
    var category: String
    var heading: String
    var author: String
    var content: String
    var body: some View {
        ScrollView{
            VStack{
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: image)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: UIScreen.main.bounds.size.width, height: 200)

                    
                } else {
                    // Fallback on earlier versions
                }
                HStack{
                    VStack(alignment: .leading){
                        Text(heading)
                            .font(.title)
                            .fontWeight(.black)
                            .multilineTextAlignment(.leading)
                            .padding([.top, .leading], 10.0)
                        Text(category)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding([.leading, .bottom], 10.0)
                        Text(author)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding(.leading, 10.0)
                        Divider()
                            .padding(5)
                        Text(content)
                            .font(.body)
                            .fontWeight(.light)
                            .padding(15)
                            .lineSpacing(3)

                        
                    }
                    Spacer()
                }
                Spacer()
                
            }
        }
    }
}

struct HomeCardItemView_Previews: PreviewProvider {
    static var previews: some View {
        HomeSheetView(image: "https://staticg.sportskeeda.com/editor/2021/01/c79f9-16100332483585-800.jpg", category: "App Update", heading: "Ascent AR Quiz", author: "RAYAN SYED", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eget eros consectetur, luctus metus ac, maximus elit. Etiam rhoncus, ipsum id accumsan posuere, nulla dui auctor lectus, id ullamcorper erat justo ac lacus. In sit amet commodo felis. Aliquam in semper purus. Mauris sit amet sagittis justo, quis mattis nisl. Sed vitae massa eros. Curabitur in elit ultrices urna feugiat molestie in et lorem. Quisque in venenatis urna. Ut ac volutpat erat. Aliquam gravida sem a molestie dapibus. Cras ex nulla, efficitur eu sodales sed, dignissim nec neque. Nam sed ornare lacus, non molestie dui. Sed maximus, sem ac rhoncus placerat, magna massa imperdiet dui, vitae varius magna tortor ac nunc. Maecenas convallis faucibus urna ac gravida. Sed commodo, odio eu venenatis dictum, nisi dui dictum massa, eu auctor metus nisi ut mi. Morbi in ultrices sem.")
    }
}

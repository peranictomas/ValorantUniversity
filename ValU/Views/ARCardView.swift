//
//  CardView.swift
//  ValU
//
//  Created by Rayan Syed on 2021-10-08.
//

import SwiftUI

struct ARCardView: View {
    var image: String
    var title: String
    var description: String
    var destination: AnyView
    var body: some View {
        VStack{
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
            HStack{
                VStack(alignment: .leading){
                    Text(title)
                        .font(.title2)
                        .fontWeight(.black)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 2.5)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(3)
                        
                    Text(description)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.primary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(5)
                    NavigationLink(destination: AnyView(destination)){
                        Text("Enter")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 39)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                    }
                }
                .layoutPriority(100)
                Spacer()
            }
            .padding()

        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
        )
        .padding([.top, .horizontal])
    }
}

//struct ARCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARCardView(image:"ARPlanningTable", title: "Planning Table", description: "Select the map of your choice and create your own strategey by placing characters and their abilities around the map.", destination:AnyView(PlanningTableView()))
//
//
//    }
//}

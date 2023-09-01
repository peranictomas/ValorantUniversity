//
//  HomePage.swift
//  ValU
//
//  Created by Rayan Syed on 2021-10-08.
//

import SwiftUI

struct NewsPageView: View {
    
    @State var showSheet = false
    @ObservedObject private var viewModel = NewsViewModel()
    
    var body: some View {
        VStack{
            HStack{
                    VStack(alignment: .leading){
//                        Text("Welcome To Valorant University!")
//                            .font(.title3)
//                            .fontWeight(.black)
//                            .padding([.top, .leading], 17)
//                        Text("You can find the latest news below and use the tabs to explore the app.")
//                            .font(.subheadline)
//                            .fontWeight(.light)
//                            .padding(.leading, 17)
//                            .padding(.top, 2.0)

                        Text("&#x2193; Latest News")
                            .font(.headline)
                            .fontWeight(.heavy)
                            .padding(.leading, 17)
                            .padding(.top, 5.0)
                    }
                    Spacer()

                }
                Spacer()
            
            List(viewModel.news) { news in
                Button(action:{
                    self.showSheet=true
                }){
                    VStack{
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: URL(string: news.image)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            //.frame(width: 300, height: 150)
                            .aspectRatio(contentMode: .fill)

                            
                        } else {
                            // Fallback on earlier versions
                        }

                        
                        HStack{
                            VStack(alignment: .leading){
                                Text(news.category)
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Text(news.heading)
                                    .font(.title2)
                                    .fontWeight(.black)
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                Text(news.author.uppercased())
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .layoutPriority(100)
                            Spacer()
                        }
                        .padding()

                    }
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 3)
                    )
                    .padding([.bottom, .top])
                }
                .sheet(isPresented: self.$showSheet){
                    HomeSheetView(image: news.image, category: news.category, heading: news.heading, author: news.author, content: news.content)
                }
                }
            }
            .onAppear() {
                self.viewModel.fetchData()
                
            }
            .navigationBarTitle("News", displayMode: .inline)
        }
}
                
struct NewsPageView_Previews: PreviewProvider {
    static var previews: some View {
        NewsPageView()
    }
}

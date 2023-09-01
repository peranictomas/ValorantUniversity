//
//  HomeView.swift
//  ValorantUniversity
//
//  Created by Rayan Syed on 2021-09-15.
//

import SwiftUI

struct Box: Identifiable {
    var id:Int
    var title, imageURL: String
    
}

struct BoxView:View{
    let box: Box
    var body: some View {
        ZStack{
            Image("\(box.imageURL)")
                .resizable()
                .renderingMode(.original)
                .scaledToFill()
                .clipped()
                .overlay(Color.black.opacity(0.2))
                .frame(width: 200, height: 250)



            VStack{
                Text("\(box.title)")
                    .padding()
                    .font(.system(size: 18, weight: .semibold, design:.rounded))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 250, alignment: .bottomTrailing)
                    
            }
        }
        .frame(width: 200, height: 250, alignment: .bottomTrailing)
        .cornerRadius(10.0)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 3, x: 3, y: 3)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 3, x: -3, y: -3)
    }

}




struct HomePageView: View {
    
    let Boxes:[Box] = [
        Box(id: 0, title: "Watch Tutorials", imageURL: "watchTutorial"),
        Box(id: 1, title: "Find Coaches", imageURL: "tenz"),
        Box(id: 2, title: "Test Yourself", imageURL: "SovaIcon"),
        Box(id: 3, title: "Earn Credits", imageURL: "achievement"),
        Box(id: 4, title: "Track Your Progress", imageURL: "lineGraph")
    ]
    @StateObject var model = AccountViewModel()
    var body: some View {

        NavigationView{
            ScrollView{
                VStack{
                    VStack{
                        HStack{
                            if model.users.indices.contains(0) {
                                Text("Welcome, \(model.users[0].firstName)!")
                                    .font(.system(size: 25, weight: .bold, design:.rounded))
                                    .padding(.leading, 25)
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)

                            }
                            Spacer()
                        }
                        HStack{
                            Text("Quick Access")
                                .font(.system(size: 18, weight: .semibold, design:.rounded))
                                .padding(.leading, 25)
                                Spacer()
                            }
                        }
                    .padding(.top)
                
                
                    NavigationLink(destination: NewsPageView()){
                        ZStack{
                            Image("AscentMap")
                                .resizable()
                                .renderingMode(.original)
                                .overlay(Color.black.opacity(0.3))
            
                            VStack{
                                Label("Latest News", systemImage: "newspaper.fill")
                                    .padding()
                                    .font(.system(size: 15, weight: .semibold, design:.rounded))
                                    .foregroundColor(.white)
                                    .frame(width: 360, height: 150, alignment: .bottomTrailing)
                                    
                            }
                        }
                        .frame(width: 360, height: 150, alignment: .bottomTrailing)
                        .cornerRadius(15.0)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 3, x: 3, y: 3)
                        .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 3, x: -3, y: -3)

                    }
                    .padding(.bottom)


                    HStack{
                        NavigationLink(destination: ProfilePageView()){
                            ZStack{
                                Image("OmenIcon")
                                    .resizable()
                                    .renderingMode(.original)
                                    .overlay(Color.purple.opacity(0.5))
                
                                VStack{
                                    Label("Profile", systemImage: "person.fill")
                                        .padding()
                                        .font(.system(size: 15, weight: .semibold, design:.rounded))
                                        .foregroundColor(.white)
                                        .frame(width: 165, height: 165, alignment: .bottomTrailing)
                                        
                                }
                            }
                            .frame(width: 165, height: 165, alignment: .bottomTrailing)
                            .cornerRadius(15.0)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: 5, y: 5)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: -5, y: -5)
                        }
                        .padding(.trailing, 20.0)

                        NavigationLink(destination: AchievementsView()){
                            ZStack{
                                Image("SageIcon")
                                    .resizable()
                                    .renderingMode(.original)
                                    .overlay(Color.blue.opacity(0.4))
                
                                VStack{
                                    Label("Achievements", systemImage: "dpad.fill")
                                        .padding()
                                        .font(.system(size: 15, weight: .semibold, design:.rounded))
                                        .foregroundColor(.white)
                                        .frame(width: 165, height: 165, alignment: .bottomTrailing)
                                        
                                }
                            }
                            .frame(width: 165, height: 165, alignment: .bottomTrailing)
                            .cornerRadius(15.0)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: 5, y: 5)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: -5, y: -5)
                        }
                        
                    }
                    .padding(.bottom, 10)
                    
                    HStack{
                        NavigationLink(destination: SettingsView()){
                            ZStack{
                                Image("KilljoyIcon")
                                    .resizable()
                                    .renderingMode(.original)
                                    .overlay(Color.yellow.opacity(0.5))
                
                                VStack{
                                    Label("Settings", systemImage: "gearshape.fill")
                                        .padding()
                                        .font(.system(size: 15, weight: .semibold, design:.rounded))
                                        .foregroundColor(.white)
                                        .frame(width: 165, height: 165, alignment: .bottomTrailing)
                                        
                                }
                            }
                            .frame(width: 165, height: 165, alignment: .bottomTrailing)
                            .cornerRadius(15.0)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: 5, y: 5)
                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: -5, y: -5)
                        }
                        .padding(.trailing, 20.0)

//                        NavigationLink(destination: ARPageView()){
//                            ZStack{
//                                Image("ViperIcon")
//                                    .resizable()
//                                    .renderingMode(.original)
//                                    .overlay(Color.green.opacity(0.4))
//
//                                VStack{
//                                    Label("AR", systemImage: "arkit")
//                                        .padding()
//                                        .font(.system(size: 15, weight: .semibold, design:.rounded))
//                                        .foregroundColor(.white)
//                                        .frame(width: 165, height: 165, alignment: .bottomTrailing)
//
//                                }
//                            }
//                            .frame(width: 165, height: 165, alignment: .bottomTrailing)
//                            .cornerRadius(15.0)
//                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: 5, y: 5)
//                            .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2290748445)), radius: 5, x: -5, y: -5)
//                        }
                        
                    }
                    .padding(.bottom, 10)
                    
                    Spacer()
                    HStack{
                        Text("Features")
                            .font(.system(size: 18, weight: .semibold, design:.rounded))
                            .padding(.leading, 25)
                            Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: true){
                        HStack{
                            ForEach(Boxes){ box in
                                BoxView(box: box)
                                    .padding(.trailing, 20.0)

                            }
                        }
                        .padding(.bottom)
                        .padding(.leading, 20.0)
                        .padding(.trailing, 20.0)

                    }
                    Spacer()
                    
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                
            }

            
        }
        .onAppear(){
            Task {
                await self.model.showCurrentUser()
            }
        }

    }

    
}


struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

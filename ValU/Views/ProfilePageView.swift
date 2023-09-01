//
//  ProfilePageView.swift
//  ValU
//
//  Created by Rayan Syed on 2021-11-21.
//

import SwiftUI

struct ProfilePageView: View {
    @ObservedObject var model = AccountViewModel()
    @ObservedObject var achievementViewModel = AchievementViewModel()
//    @State var achievementList = achievementViewModel.allAchievements

    var body: some View {


        VStack{
            VStack{
                Image("OmenIcon")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                if model.users.indices.contains(0) {
                    Text("\(model.users[0].firstName) \(model.users[0].lastName)")
                        .font(.title)
                        .bold()
                    HStack{
                        Image(systemName: "c.circle.fill")
                        Text("1250")
                            .font(.system(size: 20, weight: .bold, design:.rounded))
                            .padding(.bottom, 0.5)
                            .padding(.top, 0.5)
                    }
                    
                    
                }
            }
            Spacer().frame(height: 30)
            VStack(alignment: .leading, spacing: 12) {
                HStack{
                    Image(systemName: "envelope")
                    if model.users.indices.contains(0) {
                        Text("\(model.users[0].email)")
                            .font(.system(size: 14, weight: .semibold, design:.rounded))
                    }
                }
                Button(action: model.logOut, label: {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                })
            }

            
            Spacer()
        }.onAppear(){
            Task{
                await self.model.showCurrentUser()
            }
        }
        .navigationBarTitle("Profile")

    }

}


struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}










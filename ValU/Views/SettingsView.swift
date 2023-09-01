//
//  SettingsView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-27.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var model: AccountViewModel
    var body: some View {
        ZStack {
            VStack {
                if model.users.indices.contains(0) {
                    Text("\(model.users[0].firstName) \(model.users[0].lastName)").font(.system(size: 35, weight: .heavy)).foregroundColor(.black)
                }

                VStack(spacing: 20) {
                    Text("Add your Riot Games Account Below")
                    TextFieldView(placeHolder: "Enter Valorant ID", txt: $model.riotID)
                    TextFieldView(placeHolder: "Enter Valorant Tagline", txt: $model.riotTagLine)
                }
                .padding(.top)
                Button("Verify Your Account") {
                    Task {
                        await model.checkValorantID()
                    }
                }
                .foregroundColor(Color(red: 0.998, green: 0.277, blue: 0.329))
                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                .background(Color.white)
                .clipShape(Capsule())
                .padding(.top, 20)

                HStack(spacing: 10) {
                    Text("Want to logout?")
                        .foregroundColor(Color.white.opacity(0.7))

                    Button(action: model.logOut, label: {
                        Text("LogOut")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    })
                }
                .padding(.top, 20)

                Spacer(minLength: 0)
            }
            .padding(.top, 180)

            if model.isLoading {
                LoadingView()
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color(hue: 0.988, saturation: 0.529, brightness: 0.97), Color(red: 0.998, green: 0.277, blue: 0.329)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMessage), dismissButton: .destructive(Text("Ok")))
        })
        .onAppear {
            Task {
                await self.model.showCurrentUser()
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

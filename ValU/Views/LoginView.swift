//
//  LoginView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-23.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var model: AccountViewModel
    var body: some View {
        ZStack {
            VStack {
                Text("Valorant University").font(.system(size: 35, weight: .heavy)).foregroundColor(.black)
                Image(uiImage: UIImage(named: "valorantlogo.png")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250, alignment: .center)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)

                HStack(spacing: 0) {
                    Text("Where gaming is your homework").foregroundColor(Color.black.opacity(0.3)).fontWeight(.heavy)
                }
                .padding(.top)

                VStack(spacing: 20) {
                    TextFieldView(placeHolder: "Email", txt: $model.email)

                    TextFieldView(placeHolder: "Password", txt: $model.password)
                }
                .padding(.top)

                Button(action: model.login) {
                    Text("LOGIN")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.998, green: 0.277, blue: 0.329))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 20)

                HStack(spacing: 10) {
                    Text("Aren't Registered?")
                        .foregroundColor(Color.white.opacity(0.7))

                    Button(action: { model.isRegistered.toggle() }) {
                        Text("Sign Up Now")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 20)

                Spacer(minLength: 0)

                Button(action: model.resetPassword) {
                    Text("Forgot Password?")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 60)
            }

            if model.isLoading {
                LoadingView()
            }
        }
        .background(LinearGradient(gradient: .init(colors: [Color(hue: 0.988, saturation: 0.529, brightness: 0.97), Color(red: 0.998, green: 0.277, blue: 0.329)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))
        .fullScreenCover(isPresented: $model.isRegistered) {
            RegisterView(model: model)
        }
        .alert(isPresented: $model.linkSent) {
            Alert(title: Text("Message"), message: Text("A link has now been sent to your inbox :)"), dismissButton: .destructive(Text("Ok")))
        }
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMessage), dismissButton: .destructive(Text("Ok")))
        })
    }
}

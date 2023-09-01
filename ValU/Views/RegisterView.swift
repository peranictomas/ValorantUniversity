//
//  RegisterView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-09-23.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject var model: AccountViewModel

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top), content: {
            VStack {
                Text("New User").font(.system(size: 35, weight: .heavy)).foregroundColor(.black)
                Image(uiImage: UIImage(named: "valorantlogo.png")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180, alignment: .center)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(30)

                HStack(spacing: 0) {
                    Text("Register for an account below").foregroundColor(Color.black.opacity(0.3)).fontWeight(.heavy)
                }
                .padding(.top)

                VStack(spacing: 10) {
                    TextFieldView(placeHolder: "First Name", txt: $model.firstName)

                    TextFieldView(placeHolder: "Last Name", txt: $model.lastName)

                    TextFieldView(placeHolder: "Email", txt: $model.register_email)

                    TextFieldView(placeHolder: "Password", txt: $model.register_password)

                    TextFieldView(placeHolder: "Confirm Password", txt: $model.verify_password)

                    HStack(spacing: 0) {
                        Text("Are you signing up as a Coach?").foregroundColor(Color.black.opacity(0.3)).fontWeight(.heavy)
                        Toggle("", isOn: $model.isCoach).toggleStyle(SwitchToggleStyle(tint: .black)).labelsHidden().padding(.leading)
                    }
                }
                .padding(.top)

                Button(action: model.signup) {
                    Text("REGISTER")
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.998, green: 0.277, blue: 0.329))
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 30)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.vertical, 20)

                Spacer(minLength: 0)
            }

            Button(action: { model.isRegistered.toggle() }) {
                Text("x")
                    .frame(width: 10, height: 10)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            }
            .padding(.trailing, 20)

            if model.isLoading {
                LoadingView()
            }

        })
            .background(LinearGradient(gradient: .init(colors: [Color(hue: 0.988, saturation: 0.529, brightness: 0.97), Color(red: 0.998, green: 0.277, blue: 0.329)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea(.all, edges: .all))

            // Alert
            .alert(isPresented: $model.alert, content: {
                Alert(title: Text("Message"), message: Text(model.alertMessage), dismissButton: .destructive(Text("Ok"), action: {
                    // Close signup view when sending link
                    if model.alertMessage == "Please verify your email, a link was sent to your inbox." {
                        model.isRegistered.toggle()
                        model.firstName = ""
                        model.lastName = ""
                        model.register_email = ""
                        model.register_password = ""
                        model.verify_password = ""
                    }

                }))

            })
    }
}

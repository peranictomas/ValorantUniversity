//
//  NewTutorialView.swift
//  ValU
//
//  Created by Wahab  on 2021-09-20.
//

import Firebase
import SwiftUI

struct NewTutorialView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel = TutorialsViewModel()

    let agentList: [String] = [
        "Astra", "Breach", "Brimstone", "Cypher", "Jett", "KAY/O", "Killjoy", "Omen", "Phoenix", "Raze", "Sage", "Sova", "Viper", "Yoru",
    ]

    let mapList: [String] = [
        "Ascent", "Bind", "Breeze", "Fracture", "Haven", "Icebox", "Split",
    ]

    let phaseList: [String] = ["All Phases", "Defense", "Attack"]

    @State var title: String = ""
    @State var agentSelect: String = "Astra"
    @State var mapSelect: String = "Ascent"
    @State var phaseSelect: String = "All Phases"
    @State var tags: String = ""
    @State var videoID: String = ""
    @State var userEmail: String = ""

    var body: some View {
        Form {
            Section(header: Text("New Tutorial")) {
            }
            TextField("Title", text: $title)
//            Section(header: Text("")){
            Picker(
                selection: $agentSelect,
                label:
                HStack {
                    Text("Agent: ")
                    Text(agentSelect)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10),
                content: {
                    ForEach(agentList, id: \.self) { option in
                        Text(option)
                            .tag(option)
                    }
                }).pickerStyle(MenuPickerStyle())
                .padding()

            Picker(
                selection: $mapSelect,
                label:
                HStack {
                    Text("Map: ")
                    Text(mapSelect)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10),
                content: {
                    ForEach(mapList, id: \.self) { option in
                        Text(option)
                            .tag(option)
                    }
                }).pickerStyle(MenuPickerStyle())
                .padding()

            Picker(
                selection: $phaseSelect,
                label:
                HStack {
                    Text("Phase: ")
                    Text(phaseSelect)
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal)
                .background(Color.blue)
                .cornerRadius(10)
                .shadow(color: Color.blue.opacity(0.3), radius: 10, x: 0, y: 10),
                content: {
                    ForEach(phaseList, id: \.self) { option in
                        Text(option)
                            .tag(option)
                    }
                }).pickerStyle(MenuPickerStyle())
                .padding()

            TextField("Tags (Defense, Smoke, One Way)", text: $tags)
            TextField("Video ID", text: $videoID)



            Button(action: {
                handleButtonPressed()
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Post".uppercased())
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal, 20)
                    .background(Color.blue.cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/))
            })
        }
    }

    func handleButtonPressed() {
        let tagArray = tags.components(separatedBy: ", ")
        let tutorial: Tutorial = Tutorial(title: title, agent: agentSelect, map: mapSelect, phase: phaseSelect, tags: tagArray, videoID: videoID, userEmail: Auth.auth().currentUser?.email ?? "")
        viewModel.addTutorial(tutorial: tutorial)
    }
}

struct NewTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        NewTutorialView()
    }
}

//
//  TutorialsListView.swift
//  ValorantUniversity
//
//  Created by Rayan Syed on 2021-09-14.
//

import AVKit
import Firebase
import SwiftUI


struct TutorialsListView: View {

    @ObservedObject private var viewModel = TutorialsViewModel()
    @StateObject var accountModel = AccountViewModel()
    @State var videoID: String
    @State private var isShowingTutorialSheet = false
    @State private var isShowingNewTutorialSheet = false
    @State private var isShowingRandomSheet = false
    @State var title: String = ""
    @State var agentSelect: String = "All Agents"
    @State var mapSelect: String = "All Maps"
    @State var phaseSelect: String = "All Phases"
    @State var isShowingMyTutorialsSheet = false

    let agentList: [String] = [
        "All Agents", "Astra", "Breach", "Brimstone", "Cypher", "Jett", "KAY/O", "Killjoy", "Omen", "Phoenix", "Raze", "Sage", "Sova", "Viper", "Yoru",
    ]

    let mapList: [String] = [
        "All Maps", "Ascent", "Bind", "Breeze", "Fracture", "Haven", "Icebox", "Split",
    ]

    let phaseList: [String] = ["All Phases", "Defense", "Attack"]

    var body: some View {
        VStack {
            Section(header: Text("")) {
                HStack{
                    Button(action: {
                        isShowingMyTutorialsSheet = true

                    }) {
                        Label("My Tutorials", systemImage: "arrow.up.and.person.rectangle.portrait")
                            .sheet(isPresented: $isShowingMyTutorialsSheet, content: { MyTutorialsListView() })
                    }
                    
                    Button(action: {
                        isShowingNewTutorialSheet = true

                    }) {
                        Label("Add Tutorials", systemImage: "plus.circle.fill")
                            .padding(.leading, 30)
                            .sheet(isPresented: $isShowingNewTutorialSheet, content: { NewTutorialView() })
                    }
                    
                }
                
                HStack {
                    Picker(
                        selection: $agentSelect,
                        label:
                        HStack {
                            Text(agentSelect)
                        }
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding()
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
                            Text(mapSelect)
                        }
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 5)
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
                            Text(phaseSelect)
                        }
                        .font(.caption2)
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
                }

                Button(action: {
                    filterTutorials()
                    print("HELLLLLLLLO")
                }, label: {
                    Text("Filter".uppercased())
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, 20)
                        .background(Color.blue.cornerRadius(10).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/))
                })
            }

            List(viewModel.tutorials) { tutorial in
                VStack(alignment: .leading) {
                    VStack {
                        Text(tutorial.title).font(.headline)
                            .lineLimit(3)
                    }
                    
                    HStack(alignment: .center) {
                        Image("\(tutorial.agent)")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .cornerRadius(90)
                        Image("\(tutorial.map)")
                            .resizable()
                            .frame(width: 125, height: 50)
                            .cornerRadius(10)
                        
                        
                        Button(action: {
                            isShowingTutorialSheet = true
                            videoID = tutorial.videoID

                                }) {
                                    Image(systemName: "chevron.forward.circle.fill")
                                    .renderingMode(.original)
                                    .padding(.leading, 30)
                                }
                    }
                }

            
            }
            .sheet(isPresented: $isShowingTutorialSheet, content: {
                TutorialView(videoID: $videoID)
            })

            .navigationBarTitle("Tutorials")
            .onAppear {
                self.viewModel.filter(title: title, agent: agentSelect, map: mapSelect, phase: phaseSelect)
            }
        }
    }

    func filterTutorials() {
        viewModel.filter(title: title, agent: agentSelect, map: mapSelect, phase: phaseSelect)
    }
}

struct TutorialsListView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialsListView(videoID: "FoYc1wMLNf0")
    }
}

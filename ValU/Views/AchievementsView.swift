//
//  AchievementsView.swift
//  ValU
//
//  Created by Rayan Syed on 2021-11-28.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var achievementViewModel = AchievementViewModel()
    var body: some View {
        VStack{
//            VStack{
//                HStack{
//                    Text("Achievements")
//                        .font(.system(size: 28, weight: .bold, design:.rounded))
//                        .bold()
//                        .padding([.leading, .top])
//                    Spacer()
//                }
//            }
            List (achievementViewModel.userAchievements){ achievement in
                VStack(spacing: 1){
                    HStack{
                        Text("\(achievement.title)")
                            .font(.system(size: 18, weight: .semibold, design:.rounded))
//                            print(achievement.title)
//                            print(achievement.description)
                        Spacer()

                    }
//                        .padding([.leading, .trailing, .top])
                    VStack(alignment: .leading){
                        HStack{
                            Text("\(achievement.description)")
                                .frame(width: .infinity, height: 50, alignment: .leading)
                                .font(.system(size: 14, weight: .regular, design:.rounded))
                                .lineLimit(nil)
                        }

                        HStack{
                            Image(systemName: "c.circle.fill")
                                .resizable()
                                .frame(width: 14, height: 14)
                            Text("\(achievement.score)")
                                .font(.system(size: 14, weight: .bold, design:.rounded))
                                .padding(.bottom, 2.5)
                            Spacer()
                            Text("\(achievement.percentCompleted, specifier: "%.0f")%")
                                .font(.system(size: 14, weight: .bold, design:.rounded))
                                .padding(.bottom, 2.5)
                            
                        }
                        .padding(.bottom, 5)
       

                    }
                    
                    VStack{
                        HStack{
                            if (achievement.percentCompleted == 0.0){
//                                    Image(systemName: "circle")
//                                        .foregroundColor(Color.gray)
                                ProgressBar(width: 335, height: 10, percent: achievement.percentCompleted, color1: Color.red, color2: Color.orange)
                            } else if (achievement.percentCompleted > 0.0 && achievement.percentCompleted < 100) {
//                                    Image(systemName: "circle.lefthalf.fill")
//                                        .foregroundColor(Color.red)
                                ProgressBar(width: 335, height: 10, percent: achievement.percentCompleted, color1: Color.red, color2: Color.orange)

                            } else {
                                if #available(iOS 15.0, *) {
//                                        Image(systemName: "checkmark.circle.fill")
//                                            .foregroundColor(Color.green)
                                    ProgressBar(width: 335, height: 10, percent: achievement.percentCompleted, color1: Color.green, color2: Color.mint)
                                } else {
                                    // Fallback on earlier versions
                                }

                            }
                            
                        }

                    }
                }

            }
            .listStyle(.plain)

        }
        Spacer()
        .onAppear(){
            Task{
                self.achievementViewModel.addAchievementsToDatabase()
                self.achievementViewModel.fetchData()
//                self.achievementViewModel.updateAchievementPercent(achievementId: "ascentQuiz", percentCompleted: 100.0)
            }
        }
        .navigationBarTitle("Achievements")
        
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}

//
//  MatchView.swift
//  ValU
//

import SwiftUI
import SwiftUICharts

struct MatchView: View {
    @Binding var matchID: String
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var model: AccountViewModel
    @State var matchInfo: MatchInfoResponse!
    @State var bluePlayerList: [GamePlayer] = []
    @State var redPlayerList: [GamePlayer] = []
    @State var allPlayerList: [GamePlayer] = []
    @State var mapId = ""
    @State var gameMode = ""
    //@State var gameStartTime: Date = Date.now
    @State var gameLengthTime = 0
    @State var gameLengthString : NSString = ""
    @State var allPlayerKills = 0
    @State var allPlayerAssists = 0
    @State var allPlayerDeaths = 0
    @State var myPlayerKills = 0
    @State var myPlayerAssists = 0
    @State var myPlayerDeaths = 0
    @State var playerCount = 0

    var body: some View {
        ScrollView(.vertical, showsIndicators: true){
        VStack(alignment: .center) {
            ZStack(){
                Image(mapId)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .infinity)
                    .overlay(Color.black.opacity(0.4))
//                    .frame(width: 100, height: 100)
//                    .cornerRadius(90)
//                    .padding(.top,25)
//                Text(gameMode)
                VStack{
                    Spacer()
                    HStack{
                        Text("Match Overview")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                        Spacer()
                        
                    }
                    .padding(.leading, 10)
                    
                    HStack{
                        Text("Length: \(gameLengthString)")
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    .padding([.leading, .bottom], 10)

                }

                    

                //Text("\(gameStartTime)")
                
            }
            
//            HStack{
//                Spacer()
//                Text("S   ").fontWeight(.bold)
//                Text("K ").fontWeight(.bold)
//                Text("D").fontWeight(.bold)
//                Text("A")
//                    .fontWeight(.bold)
//                    .padding(.trailing, 20)
//
//            }
            HStack{
                Text("Scoreboard")
                    .fontWeight(.bold)
                    .font(.headline)
                    .padding(.leading, 10)
                Spacer()
                Text("S   ").fontWeight(.bold)
                Text("K ").fontWeight(.bold)
                Text("D").fontWeight(.bold)
                Text("A")
                    .fontWeight(.bold)
                    .padding(.trailing, 20)
                
            }
            
            VStack{

                ForEach(bluePlayerList, id: \.self) { player in
                    
                    
                    HStack{
                        Image("\(player.competitiveTier)").padding(.leading, 10)
                        Image("\(player.characterID)").padding(.leading, 2)
                        Text(player.gameName).padding(.leading, 0.5)
                        Text("#\(player.tagLine)")
                        Spacer()
                        Text(String(player.score))
                        Text(String(player.kills))
                        Text(String(player.deaths))
                        Text(String(player.assists)).padding(.trailing, 10)
                    }.padding(.top, 2)
                    Divider()
                }
                
            }
            .background(Color(#colorLiteral(red: 0, green: 0.4903462188, blue: 1, alpha: 0.5)))
            .cornerRadius(10)
            .shadow(color: Color(#colorLiteral(red: 0, green: 0.3293940282, blue: 1, alpha: 0.5)), radius: 5, x: 5, y: 5)
            .shadow(color: Color(#colorLiteral(red: 0, green: 0.3293940282, blue: 1, alpha: 0.5)), radius: 5, x: -5, y: -5)
            .padding([.leading, .trailing, .bottom], 10)


            VStack{
                ForEach(redPlayerList, id: \.self) { player in
                    
                    HStack{
                        Image("\(player.competitiveTier)").padding(.leading, 10)
                        Image("\(player.characterID)").padding(.leading, 0.5)
                        Text(player.gameName).padding(.leading, 2)
                        Text("#\(player.tagLine)")
                        Spacer()
                        Text(String(player.score))
                        Text(String(player.kills))
                        Text(String(player.deaths))
                        Text(String(player.assists)).padding(.trailing, 10)
                    }.padding(.top, 2)
                    Divider()
                }
                
            }
            .background(Color(#colorLiteral(red: 1, green: 0, blue: 0.1775650433, alpha: 0.5)))
            .cornerRadius(10)
            .shadow(color: Color(#colorLiteral(red: 1, green: 0.05610767772, blue: 0, alpha: 0.5)), radius: 5, x: 5, y: 5)
            .shadow(color: Color(#colorLiteral(red: 1, green: 0.05610767772, blue: 0, alpha: 0.5)), radius: 5, x: -5, y: -5)
            .padding(.leading, 10)
            .padding(.trailing, 10)

            HStack{
                Text("Details")
                    .fontWeight(.bold)
                    .font(.headline)
                    .padding(.leading, 10)
                Spacer()
            }
            
            ForEach(allPlayerList, id: \.self) { player in
                if(player.puuid == model.riotPUUID)
                {

                    ScrollView(.horizontal, showsIndicators: true){
                        HStack{
                            let killData = makeKillData()

                            DoughnutChart(chartData: killData)
                                            .touchOverlay(chartData: killData)
                                            .headerBox(chartData: killData)
                                            .legends(chartData: killData, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                                            .frame(minWidth: 215, maxWidth: 215, minHeight: 215, idealHeight: 215, maxHeight: 215, alignment: .center)
                                            .id(killData.id)
                                            .padding(.horizontal)
                            
                            let deathData = makeDeathData()

                            DoughnutChart(chartData: deathData)
                                            .touchOverlay(chartData: deathData)
                                            .headerBox(chartData: deathData)
                                            .legends(chartData: deathData, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                                            .frame(minWidth: 215, maxWidth: 215, minHeight: 215, idealHeight: 215, maxHeight: 215, alignment: .center)
                                            .id(deathData.id)
                                            .padding(.horizontal)
                            
                            let assistData = makeAssistData()
                            
                            DoughnutChart(chartData: assistData)
                                            .touchOverlay(chartData: assistData)
                                            .headerBox(chartData: assistData)
                                            .legends(chartData: assistData, columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())])
                                            .frame(minWidth: 215, maxWidth: 215, minHeight: 215, idealHeight: 215, maxHeight: 215, alignment: .center)
                                            .id(deathData.id)
                                            .padding(.horizontal)
                        }
                    }
                }
            }

            
        }.onAppear(){
            getMatchInfoByMatchID(matchID: matchID, puuid: model.riotPUUID)
        }
        }
    }
    
    func stringFromTimeInterval(interval: Int) -> NSString {
        
        let newInterval = interval / 1000
        let hours = (Int(newInterval) / 3600)
        let minutes = Int(newInterval / 60) - Int(hours * 60)
        let seconds = Int(newInterval) - (Int(newInterval / 60) * 60)

        return NSString(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
    
    func makeKillData() -> DoughnutChartData {
        let data = PieDataSet(
            dataPoints: [
                PieChartDataPoint(value: Double(self.myPlayerKills), description: "My Kills"  , colour: .blue  , label: .label(text: "\(Double(self.myPlayerKills))"  , rFactor: 0.8)),
                PieChartDataPoint(value: Double(self.allPlayerKills/self.playerCount), description: "Avg Kills"  , colour: .red   , label: .label(text: "\(Double(self.allPlayerKills/self.playerCount))"  , rFactor: 0.8))
                ],
            legendTitle: "Data")
        
        return DoughnutChartData(dataSets: data,
                                 metadata: ChartMetadata(title: "Kills", subtitle: ""),
                                 chartStyle: DoughnutChartStyle(infoBoxPlacement: .header),
                                 noDataText: Text("no data found"))
    }
    
    func makeDeathData() -> DoughnutChartData {
        let data = PieDataSet(
            dataPoints: [
                PieChartDataPoint(value: Double(self.myPlayerDeaths), description: "My Deaths"  , colour: .blue  , label: .label(text: "\(Double(self.myPlayerDeaths))"  , rFactor: 0.8)),
                PieChartDataPoint(value: Double(self.allPlayerDeaths/self.playerCount), description: "Avg Deaths"  , colour: .red   , label: .label(text: "\(Double(self.allPlayerDeaths/self.playerCount))"  , rFactor: 0.8))
                ],
            legendTitle: "Data")
        
        return DoughnutChartData(dataSets: data,
                                 metadata: ChartMetadata(title: "Deaths", subtitle: ""),
                                 chartStyle: DoughnutChartStyle(infoBoxPlacement: .header),
                                 noDataText: Text("no data found"))
    }
    
    func makeAssistData() -> DoughnutChartData {
        let data = PieDataSet(
            dataPoints: [
                PieChartDataPoint(value: Double(self.myPlayerAssists), description: "My Assists"  , colour: .blue  , label: .label(text: "\(Double(self.myPlayerAssists))"  , rFactor: 0.8)),
                PieChartDataPoint(value: Double(self.allPlayerAssists/self.playerCount), description: "Avg Assists"  , colour: .red   , label: .label(text: "\(Double(self.allPlayerAssists/self.playerCount))"  , rFactor: 0.8))
                ],
            legendTitle: "Data")
        
        return DoughnutChartData(dataSets: data,
                                 metadata: ChartMetadata(title: "Assists", subtitle: ""),
                                 chartStyle: DoughnutChartStyle(infoBoxPlacement: .header),
                                 noDataText: Text("no data found"))
    }
    
    private func getMatchInfoByMatchID(matchID: String, puuid: String) {
        model.getMatchInfoByGameId(gameId: matchID) { error, matchInfoResponse in
            if let error = error {
                print(error.localizedDescription)
            }
//            var headshots = 0
//            var averageDamage = 0
            if let matchInfoResponse = matchInfoResponse {
                self.matchInfo = matchInfoResponse
                //print(matchInfoResponse.matchInfo)
//                for round in matchInfoResponse.roundResults {
//                    for playerStats in round.playerStats {
//                        //print("puuid: \(playerStats.puuid)")
//                        if playerStats.puuid == puuid {
//                            for damage in playerStats.damage {
//                                if damage.receiver != puuid {
//                                    headshots += damage.headshots
//                                    averageDamage += damage.damage
//                                }
//                            }
//                        }
//
//                    }
//
//                }
                for player in matchInfoResponse.players {
                    print(matchInfoResponse.matchInfo.mapId)
                    mapId = matchInfoResponse.matchInfo.mapId
                    mapId = mapId.replacingOccurrences(of: "/", with: "")
                    gameMode = matchInfoResponse.matchInfo.gameMode
                    //gameStartTime = matchInfoResponse.matchInfo.gameStartMillis
                    //gameStartTime = Date(timeIntervalSince1970: (Double(matchInfoResponse.matchInfo.gameStartMillis) / 1000.0))
                    
                    gameLengthTime = matchInfoResponse.matchInfo.gameLengthMillis
                    gameLengthString = stringFromTimeInterval(interval: gameLengthTime)
                    if(player.puuid != model.riotPUUID)
                    {
                        allPlayerKills += player.stats.kills
                        allPlayerAssists += player.stats.assists
                        allPlayerDeaths += player.stats.deaths
                        playerCount += 1
                    }
                    else{
                        myPlayerKills = player.stats.kills
                        myPlayerAssists = player.stats.assists
                        myPlayerDeaths = player.stats.deaths
                    }
                    if (player.teamId == "Blue")
                    {
                        bluePlayerList.append(GamePlayer(puuid: player.puuid, gameName: player.gameName, tagLine: player.tagLine, competitiveTier: player.competitiveTier, kills: player.stats.kills, deaths: player.stats.deaths, assists: player.stats.assists, score: player.stats.score, characterID: player.characterId, teamID: player.teamId))
                        allPlayerList.append(GamePlayer(puuid: player.puuid, gameName: player.gameName, tagLine: player.tagLine, competitiveTier: player.competitiveTier, kills: player.stats.kills, deaths: player.stats.deaths, assists: player.stats.assists, score: player.stats.score, characterID: player.characterId, teamID: player.teamId))
                    }
                    else{
                        redPlayerList.append(GamePlayer(puuid: player.puuid, gameName: player.gameName, tagLine: player.tagLine, competitiveTier: player.competitiveTier, kills: player.stats.kills, deaths: player.stats.deaths, assists: player.stats.assists, score: player.stats.score, characterID: player.characterId, teamID: player.teamId))
                        allPlayerList.append(GamePlayer(puuid: player.puuid, gameName: player.gameName, tagLine: player.tagLine, competitiveTier: player.competitiveTier, kills: player.stats.kills, deaths: player.stats.deaths, assists: player.stats.assists, score: player.stats.score, characterID: player.characterId, teamID: player.teamId))
                    }
                    
                    //print(player.teamId)
                    
                    print("gameName: \(player.gameName)\nTagLine: \(player.tagLine)\ncompetitiveTier: \(player.competitiveTier)\nKills: \(player.stats.kills)\nDeaths: \(player.stats.deaths)\nAssists: \(player.stats.assists)\nScore: \(player.stats.score) \nCharacter: \(player.teamId)")
                }
            }
        }
    }
    
    
    
}



struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        MatchView(matchID: .constant("FoYc1wMLNf0"))
    }
}

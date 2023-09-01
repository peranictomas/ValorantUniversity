//
//  MyProfileView.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-11-16.
//

import SwiftUI

struct MyProfileView: View {
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State var puuid: PuuidResponse!
    @State var matchList = [History]()
    @State var matchInfo: MatchInfoResponse!
    @State var matchID: String
    @State private var isShowingMatchSheet = false

    var body: some View {
        ZStack {
            List {
                ForEach(matchList, id: \.self) { match in
                    HStack {
                        Text(match.matchId).font(.headline).bold()
                        Button("View Match") {
                            isShowingMatchSheet = true
                            matchID = match.matchId
                        }.padding(.trailing, 100)
                    }
                }
            }
            .sheet(isPresented:
                $isShowingMatchSheet, content: {
                    MatchView(matchID: $matchID)
                })
            .listStyle(GroupedListStyle())
        }.onAppear {
            getPuuid()
            test()
        }
    }

    private func getPuuid() {
        accountViewModel.getPuuid(tagLine: accountViewModel.riotTagLine, gameName: accountViewModel.riotID) { error, puuidResponse in
            if let error = error {
                print(error.localizedDescription)
            }
            if let puuidResponse = puuidResponse {
                print("Puuid: \(puuidResponse.puuid)\nGameName: \(puuidResponse.gameName)\nTagLine: \(puuidResponse.tagLine)")
                self.puuid = puuidResponse
                self.getMatchListByPuuid(puuid: puuidResponse.puuid)
            }
        }
    }

    private func getMatchListByPuuid(puuid: String) {
        accountViewModel.getMatchListByPuuid(puuid: puuid) { error, matchListResponse in
            if let error = error {
                print(error.localizedDescription)
            }

            if let matchListResponse = matchListResponse {
                self.matchList = matchListResponse.history
                for match in matchListResponse.history {
                    // print("Match ID: \(match.matchId)")
                    self.getMatchInfoByMatchID(matchID: match.matchId, puuid: puuid)
                }
            }
        }
    }

    private func getMatchInfoByMatchID(matchID: String, puuid: String) {
        accountViewModel.getMatchInfoByGameId(gameId: matchID) { error, matchInfoResponse in
            if let error = error {
                print(error.localizedDescription)
            }
            var headshots = 0
            var averageDamage = 0
            if let matchInfoResponse = matchInfoResponse {
                self.matchInfo = matchInfoResponse
                // print(matchInfoResponse.matchInfo)
                for round in matchInfoResponse.roundResults {
                    for playerStats in round.playerStats {
                        // print("puuid: \(playerStats.puuid)")
                        if playerStats.puuid == puuid {
                            for damage in playerStats.damage {
                                if damage.receiver != puuid {
                                    headshots += damage.headshots
                                    averageDamage += damage.damage
                                }
                            }
                        }
                    }
                    for player in matchInfoResponse.players {
                        // print("gameName: \(player.gameName)\nTagLine: \(player.tagLine)\ncompetitiveTier: \(player.competitiveTier)\nKills: \(player.stats.kills)\nDeaths: \(player.stats.deaths)\nAssists: \(player.stats.assists)\nScore: \(player.stats.score)\nHeadshots: \(headshots)\nAverageDamage: \(averageDamage)")
                    }
                }
            }
        }
    }

    private func test() {
        for match in matchList {
            print(match.matchId)
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView(matchID: "AAA")
    }
}

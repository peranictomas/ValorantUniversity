//
//  ConvertRiotID.swift
//  ValU
//
//  Created by Tomas Peranic on 2021-10-02.
//

import Foundation

struct ConvertRiotID {
    var characters = [
        "5F8D3A7F-467B-97F3-062C-13ACF203C006": "Breach",
        "F94C3B30-42BE-E959-889C-5AA313DBA261": "Raze",
        "601DBBE7-43CE-BE57-2A40-4ABD24953621": "KAY/O",
        "6F2A04CA-43E0-BE17-7F36-B3908627744D": "Skye",
        "117ED9E3-49F3-6512-3CCF-0CADA7E3823B": "Cypher",
        "DED3520F-4264-BFED-162D-B080E2ABCCF9": "Sova",
        "1E58DE9C-4950-5125-93E9-A0AEE9F98746": "Killjoy",
        "707EAB51-4836-F488-046A-CDA6BF494859": "Viper",
        "EB93336A-449B-9C1B-0A54-A891F7921D69": "Astra",
        "9F0D8BA9-4140-B941-57D3-A7AD57C6B417": "Brimstone",
        "7F94D92C-4234-0A36-9646-3A87EB8B5C89": "Yoru",
        "569FDD95-4D10-43AB-CA70-79BECC718B46": "Sage",
        "A3BFB853-43B2-7238-A4F1-AD90E9E46BCC": "Reyna",
        "8E253930-4C05-31DD-1B6C-968525494517": "Omen",
        "ADD6443A-41BD-E414-F6AD-E58D267F4E95": "Jett"]

    var maps = [
        "7EAECC1B-4337-BBF6-6AB9-04B8F06B3319": "Ascent",
        "D960549E-485C-E861-8D71-AA9D1AED12A2": "Split",
        "B529448B-4D60-346E-E89E-00A4C527A405": "Fracture",
        "2C9D57EC-4431-9C5E-2939-8F9EF6DD5CBA": "Bind",
        "2FB9A4FD-47B8-4E7D-A969-74B4046EBD53": "Breeze",
        "E2AD5C54-4114-A870-9641-8EA21279579A": "Icebox",
        "2BEE0DC9-4FFE-519B-1CBD-7FBE763A6047": "Haven"]

    var equips = [
        "0AFB2636-4093-C63B-4EF1-1E97966E2A3E": "Spike",
        "63E6C2B6-4A8E-869C-3D4C-E38355226584": "Odin",
        "55D8A0F4-4274-CA67-FE2C-06AB45EFDF58": "Ares",
        "9C82E19D-4575-0200-1A81-3EACF00CF872": "Vandal",
        "AE3DE142-4D85-2547-DD26-4E90BED35CF7": "Bulldog",
        "EE8E8D15-496B-07AC-E5F6-8FAE5D4C7B1A": "Phantom",
        "EC845BF4-4F79-DDDA-A3DA-0DB3774B2794": "Judge",
        "910BE174-449B-C412-AB22-D0873436B21B": "Bucky",
        "44D4E95C-4157-0037-81B2-17841BF2E8E3": "Frenzy",
        "29A0CFAB-485B-F5D5-779A-B59F85E204A8": "Classic",
        "1BAA85B4-4C70-1284-64BB-6481DFC3BB4E": "Ghost",
        "E336C6B8-418D-9340-D77F-7A9E4CFE0702": "Sheriff",
        "42DA8CCC-40D5-AFFC-BEEC-15AA47B42EDA": "Shorty",
        "A03B24D3-4319-996D-0F8C-94BBFBA1DFC7": "Operator",
        "4ADE7FAA-4CF1-8376-95EF-39884480959B": "Guardian",
        "C4883E50-4494-202C-3EC3-6B8A9284F00B": "Marshal",
        "462080D1-4035-2937-7C09-27AA2A5C27A7": "Spectre",
        "F7E1B454-4AD4-1063-EC0A-159E56B58941": "Stinger",
        "2F59173C-4BED-B6C3-2191-DEA9B58BE9C7": "Melee",
        "C5DE005C-4BDC-26A7-A47D-C295EAAAE9D8": "Classic",
        "3DE32920-4A8F-0499-7740-648A5BF95470": "Golden Gun",
        "6BD46791-4F27-AA65-7D67-3F8D9D8B8B90": "Paint Shells",
        "2E20A5AF-4726-95F6-7D9C-9DB9A18DADA9": "Boom Bot",
        "D002A9A2-4B43-86C6-1DBC-58BC7815FF9C": "Blast Pack",
        "9438BE81-46B8-D8B0-8A66-F9A0251FB728": "Showstopper",
        "193C78AF-4498-4D51-C445-ADAC288425BE": "Shock Bolt",
        "D0F571D4-4220-A219-63A0-CBA1135A847A": "Big Knife",
        "2A117B48-4BED-0701-5DCD-FCAC06047735": "Snowball Launcher",
        "5261A41B-4C56-8EB5-9E46-7193F363477E": "Snowball Launcher"]

    var gameModes = [
        "96BD3920-4F36-D026-2B28-C683EB0BCAC5": "Standard",
        "A8790EC5-4237-F2F0-E93B-08A8E89865B2": "Deathmatch",
        "A4ED6518-4741-6DCB-35BD-F884AECDC859": "Escalation",
        "4744698A-4513-DC96-9C22-A9AA437E4A58": "Replication",
        "E921D1E6-416B-C31F-1291-74930C330B7B": "Spike Rush",
        "57038D6D-49B1-3A74-C5EF-3395D9F23A97": "Snowball Fight",
        "5D0F264B-4EBE-CC63-C147-809E1374484B": "Swift Play",
        "8403E16F-41DE-666E-6330-43A2A24140C5": "Swift Play Carryover",
        "10E4B36F-4F4A-DBEB-375F-D7AB71E6B75C": "Swift Play Pips"]

    var episode0 = [
        "3f61c772-4560-cd3f-5d3f-a7ab5abda6b3": "Act 1",
        "0530b9c4-4980-f2ee-df5d-09864cd00542": "Act 2",
        "46ea6166-4573-1128-9cea-60a15640059b": "Act 3",
    ]

    var episode1 = [
        "97b6e739-44cc-ffa7-49ad-398ba502ceb0": "Act 1",
        "ab57ef51-4e59-da91-cc8d-51a5a2b9b8ff": "Act 2",
        "52e9749a-429b-7060-99fe-4595426a0cf7": "Act 3",
    ]

    var episode2 = [
        "2a27e5d2-4d30-c9e2-b15a-93b8909a442c": "Act 1",
        "4cb622e1-4244-6da3-7276-8daaf1c01be2": "Act 2",
        "a16955a5-4ad0-f761-5e9e-389df1c892fb": "Act 3",
    ]

    var episode3 = [
        "573f53ac-41a5-3a7d-d9ce-d6a6298e5704": "Act 1",
        "d929bc38-4ab6-7da4-94f0-ee84f8ac141e": "Act 2",
        "3e47230a-463c-a301-eb7d-67bb60357d4f": "Act 3",
    ]

    var parentIDEpisode = [
        "fcf2c8f4-4324-e50b-2e23-718e4a3ab046": "episode0",
        "71c81c67-4fae-ceb1-844c-aab2bb8710fa": "episode1",
        "97b39124-46ce-8b55-8fd1-7cbf7ffe173f": "episode2",
        "808202d6-4f2b-a8ff-1feb-b3a0590ad79f": "episode3",
    ]

    var ceremonies = [
        "1E71C55C-476E-24AC-0687-E48B547DBB35": "Ace",
        "B41F4D69-4F9D-FFA9-2BE8-E2878CF7F03B": "Closer",
        "A6100421-4ECB-BD55-7C23-E4899643F230": "Clutch",
        "EB651C62-421F-98FC-8008-68BEE9EC942D": "Flawless",
        "87C91747-4DE4-635E-A64B-6BA4FAEEAE78": "Team Ace",
        "BF94F35E-4794-8ADD-DC7D-FB90A08D3D04": "Thrifty"]
}

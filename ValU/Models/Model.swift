//
//  Model.swift
//
//  Created by Rayan Syed on 2021-11-15.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case ability
    case map
    case agent
    var label:String{
        get{
            switch self {
            case .ability:
                return "Abilities"
            case .map:
                return "Maps"
            case .agent:
                return "Agents"
            }
            
        }
    }
    
}


class Model {
    var name:String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0){
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: {loadCompletion in
                switch loadCompletion {
                case .failure(let error): print("Unable to load model entity for \(filename) \(error)")
                case .finished:
                    break
                }
                
            },receiveValue: { modelEntity in
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                print("Model entity for \(self.name) has been loaded")
                
            })
    }
}

struct Models {
    var all: [Model] = []
    init() {
        //tables
        let phoenixWall = Model(name: "PhoenixWall", category: .ability, scaleCompensation: 25/100)
        let ascentMap = Model(name: "AscentMap", category: .map, scaleCompensation: 50/100)
        let omenSmoke = Model(name: "OmenSmoke", category: .ability, scaleCompensation: 75/100)
        let sageWall = Model(name: "SageWall", category: .ability, scaleCompensation: 40/100)

        let raze = Model(name: "Raze", category: .agent, scaleCompensation: 75/100)
        let omen = Model(name: "Omen", category: .agent, scaleCompensation: 100/100)
        let cypher = Model(name: "Cypher", category: .agent, scaleCompensation: 100/100)
        let reyna = Model(name: "Reyna", category: .agent, scaleCompensation: 2.5/100)





        
        self.all += [phoenixWall, ascentMap, omenSmoke, raze, omen, cypher, reyna, sageWall]

    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter({$0.category == category})
    }
}

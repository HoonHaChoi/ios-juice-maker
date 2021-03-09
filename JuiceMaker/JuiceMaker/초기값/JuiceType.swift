//
//  Juices.swift
//  JuiceMaker
//
//  Created by 천수현 on 2021/03/08.
//

import Foundation

typealias requirement = (Fruit: Fruit, needAmount: Int)

class Juice {
    var requirements: [requirement]
    
    init(require: [requirement]) {
        self.requirements = require
    }
    
    func canMake() -> Bool {
        for requirement in requirements {
            if requirement.Fruit.stock < requirement.needAmount {
                return false
            }
        }
        return true
    }
}

struct Juices : RawRepresentable {
    let rawValue: Juice
    static let strawberryJuice: Juice = Juice(require: Requirements.strawberryRequirement)
    static let bananaJuice = Juice(require: Requirements.bananaRequirement)
    static let kiwiJuice = Juice(require: Requirements.kiwiRequirement)
    static let pineappleJuice = Juice(require: Requirements.pineappleRequirement)
    static let strawBananaJuice = Juice(require: Requirements.strawBananaRequirement)
    static let mangoJuice = Juice(require: Requirements.mangoRequirement)
    static let mangoKiwiJuice = Juice(require: Requirements.mangoKiwiRequirement)
}

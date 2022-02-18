//
//  JuiceRecipeType.swift
//  JuiceMaker
//
//  Created by 강경 on 2022/02/16.
//

import Foundation

enum JuiceRecipeType: Hashable, CaseIterable {
    case strawberryJuice
    case bananaJuice
    case kiwiJuice
    case pineappleJuice
    case strawberryBanananJuice
    case mangoJuice
    case mangoKiwiJuice
    
    var recipe: JuiceRecipe {
        switch self {
        case .strawberryJuice:
            return .init(ingredients: [.init(fruit: .strawberry, number: 16)], name: .mangoKiwiJuice)
        case .bananaJuice:
            return .init(ingredients: [.init(fruit: .banana, number: 2)], name: .bananaJuice)
        case .kiwiJuice:
            <#code#>
        case .pineappleJuice:
            <#code#>
        case .strawberryBanananJuice:
            <#code#>
        case .mangoJuice:
            <#code#>
        case .mangoKiwiJuice:
            <#code#>
        }
    }
}

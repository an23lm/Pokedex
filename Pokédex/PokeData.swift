//
//  PokeData.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 21/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import Foundation
import UIKit

public enum Type {
    case Beauty
    case Bug
    case Cool
    case Cute
    case Dark
    case Dragon
    case Electic
    case Fire
    case Fighting
    case Flying
    case Ghost
    case Grass
    case Ground
    case Ice
    case Normal
    case Poison
    case Psychic
    case Rock
    case Smart
    case Steel
    case Tough
    case Water
    case Fairy
    case Unknown
    
    static public func getType(fromString string: String) -> Type {
        switch string {
        case "Beauty":
            return .Beauty
        case "Bug":
            return .Bug
        case "Cool":
            return .Cool
        case "Cute":
            return .Cute
        case "Dark":
            return .Dark
        case "Dragon":
            return .Dragon
        case "Electric":
            return .Electic
        case "Fire":
            return .Fire
        case "Fighting":
            return .Fighting
        case "Flying":
            return .Flying
        case "Ghost":
            return .Ghost
        case "Grass":
            return .Grass
        case "Ground":
            return .Ground
        case "Ice":
            return .Ice
        case "Normal":
            return .Normal
        case "Poison":
            return .Poison
        case "Psychic":
            return .Psychic
        case "Rock":
            return .Rock
        case "Smart":
            return .Smart
        case "Steel":
            return .Steel
        case "Tough":
            return .Tough
        case "Water":
            return .Water
        case "Fairy":
            return .Fairy
        default:
            return .Unknown
        }
    }
}

public func selectImage(type: Type) -> UIImage {
    var image: UIImage
    switch type {
    case .Beauty:
        image = UIImage(named: "beauty")!
    case .Bug:
        image = UIImage(named: "bug")!
    case .Cool:
        image = UIImage(named: "cool")!
    case .Cute:
        image = UIImage(named: "cute")!
    case .Dark:
        image = UIImage(named: "dark")!
    case .Dragon:
        image = UIImage(named: "dragon")!
    case .Electic:
        image = UIImage(named: "electric")!
    case .Fire:
        image = UIImage(named: "fire")!
    case .Fighting:
        image = UIImage(named: "fighting")!
    case .Flying:
        image = UIImage(named: "flying")!
    case .Ghost:
        image = UIImage(named: "ghost")!
    case .Grass:
        image = UIImage(named: "grass")!
    case .Ground:
        image = UIImage(named: "ground")!
    case .Ice:
        image = UIImage(named: "ice")!
    case .Normal:
        image = UIImage(named: "normal")!
    case .Poison:
        image = UIImage(named: "poison")!
    case .Psychic:
        image = UIImage(named: "psychic")!
    case .Rock:
        image = UIImage(named: "rock")!
    case .Smart:
        image = UIImage(named: "smart")!
    case .Steel:
        image = UIImage(named: "steel")!
    case .Tough:
        image = UIImage(named: "tough")!
    case .Water:
        image = UIImage(named: "water")!
    case .Fairy:
        image = UIImage(named: "fairy")!
    default:
        image = UIImage(named: "unknown")!
    }
    return image
}


public struct Pokemon {
    var id: Int = 0
    var name: String = ""
    var classification: String = ""
    var type: [Type] = []
    var weekness: [Type] = []
    var attacks: [String] = []
    var specialAttacks: [String] = []
    var candyName: String? = ""
    var candyAmount: Int? = 0
    var nextEvolution: [Pokemon] = []
    var previousEvolution: [Pokemon] = []
    var evolutionChainId: Int = 0
    var baseCaptureRate: Double = 0
    var baseFleeRate: Double = 0
    var maxCP: Int = 0
    var maxHP: Int = 0
    var baseStamina: Int = 0
    var baseAttack: Int = 0
    var baseDefense: Int = 0
    var tier: String = ""
    var powerCP: Int = 0
    var evolutionMultiplier: Float? = 0
    var primaryColor: UIColor = UIColor()
    var secondaryColor: UIColor = UIColor()
    var tertiaryColor: UIColor = UIColor()
    var eggDistance: Int? = nil
    var maxDmgTaken: Float = 0
}

public struct Attack {
    var move: String = ""
    var type: Type = .Unknown
    var isCharge: Bool = false
    var power: Int = 0
    var sec: Float = 0
    var dps: Float = 0
    var energy: Int = 0
}

public struct TypeAdvantage {
    var type: Type = .Unknown
    var advantage: [Type] = []
    var disadvantage: [Type] = []
}
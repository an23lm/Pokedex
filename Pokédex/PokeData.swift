//
//  PokeData.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 21/7/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import Foundation

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
}

func selectType(string: String) -> Type {
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

func selectImage(type: Type) -> UIImage {
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
}


private func printList(list: [Pokemon]) {
    for item in list {
        print(item.id)
        print(item.name)
        print(item.classification)
        print(item.type)
        print(item.weekness)
        print(item.attacks)
        print(item.candyName)
        print(item.candyAmount)
        print(item.nextEvolution)
        print(item.previousEvolution)
        print(item.evolutionChainId)
        print(item.baseCaptureRate)
        print(item.baseFleeRate)
        print(item.maxCP)
        print(item.maxHP)
        print(item.evolutionMultiplier)
        print("------------------------------------- END --------------------------------------------")
    }
}

private func baseInfo() -> [Pokemon] {
    
    var baseInfoPokemonList: [Pokemon] = []
    
    let file1 = NSBundle.mainBundle().pathForResource("pokemon", ofType: "json")
    
    do {
        let jsonData = try NSData(contentsOfFile: file1!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        do {
            //let jsonResult: NSArray = try NSJSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [NSDictionary]
            let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
            for poke in jsonResult {
                var tempPokemon = Pokemon()
                if let id = poke["Number"] as? String {
                    tempPokemon.id = Int(id)!
                }
                if let name = poke["Name"] as? String {
                    tempPokemon.name = name
                }
                if let classification = poke["Classification"] as? String {
                    tempPokemon.classification = classification
                }
                if let type1 = poke["Type I"] as? [String] {
                    for type in type1 {
                        let poketype: Type = selectType(type)
                        tempPokemon.type.append(poketype)
                    }
                }
                if let type2 = poke["Type II"] as? [String] {
                    for type in type2 {
                        let poketype: Type = selectType(type)
                        tempPokemon.type.append(poketype)
                    }
                }
                if let weekness = poke["Weaknesses"] as? [String] {
                    for type in weekness {
                        let poketype: Type = selectType(type)
                        tempPokemon.weekness.append(poketype)
                    }
                }
                if let attacks = poke["Fast Attack(s)"] as? [String] {
                    tempPokemon.attacks = attacks
                }
                if let nextEvol = poke["Next Evolution Requirements"] as? NSDictionary {
                    if let candy = nextEvol["Amount"] as? Int {
                        tempPokemon.candyAmount = candy
                    }
                    else {
                        tempPokemon.candyAmount = nil
                    }
                    if let candy = nextEvol["Name"] as? String {
                        tempPokemon.candyName = candy
                    }
                    else {
                        tempPokemon.candyName = nil
                    }
                }
                baseInfoPokemonList.append(tempPokemon)
            }
            return baseInfoPokemonList
        }
        catch {
            print("PokeData: \(error)")
        }
    }
    catch {
        print("PokeData: \(error)")
    }
    return []
}

func moreInfo(pokeData: [Pokemon]) -> [Pokemon] {
    
    //let file2 = Bundle.main().pathForResource("pokejson2", ofType: "json")
    let file2 = NSBundle.mainBundle().pathForResource("pokejson2", ofType: "json")
    //let url2 = URL(fileURLWithPath: file2!)
    var pokeData = pokeData
    
    do {
        //let jsonData = try Data(contentsOf: url2, options: .dataReadingMappedIfSafe)
        let jsonData = try NSData(contentsOfFile: file2!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        do {
            let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
            for poke in jsonResult {
                var tempPokemon = Pokemon()
                var index: Int = 0
                if let id = poke["PkMn"] as? Int {
                    for (i, pokemon) in pokeData.enumerate() {
                        if pokemon.id == id {
                            tempPokemon = pokemon
                            index = i
                            break
                        }
                    }
                }
                if let evolutionChainId = poke["EvolutionChainId"] as? Int {
                    tempPokemon.evolutionChainId = evolutionChainId
                }
                if let baseCaptureRate = poke["BaseCaptureRate"] as? Double {
                    tempPokemon.baseCaptureRate = baseCaptureRate
                }
                if let baseFleeRate = poke["BaseFleeRate"] as? Double {
                    tempPokemon.baseFleeRate = baseFleeRate
                }
                if let maxCP = poke["MaxCP"] as? Int {
                    tempPokemon.maxCP = maxCP
                }
                if let maxHP = poke["MaxHP"] as? Int {
                    tempPokemon.maxHP = maxHP
                }
                if let baseStam = poke["BaseStamina"] as? Int {
                    tempPokemon.baseStamina = baseStam
                }
                if let baseAtt = poke["BaseAttack"] as? Int {
                    tempPokemon.baseAttack = baseAtt
                }
                if let baseDef = poke["BaseDefense"] as? Int {
                    tempPokemon.baseDefense = baseDef
                }
                pokeData[index] = tempPokemon
            }
            return pokeData
        }
        catch {
            print("PokeData: \(error)")
        }
    }
    catch {
        print("PokeData: \(error)")
    }
    return []
}

func evolInfo(pokeData: [Pokemon]) -> [Pokemon] {
  
    let file3 = NSBundle.mainBundle().pathForResource("multiplier", ofType: "json")
    //let url3 = URL(fileURLWithPath: file3!)
    
    var pokeData = pokeData
    
    do {
        let jsonData = try NSData(contentsOfFile: file3!, options: .DataReadingMappedIfSafe)
        do {
            let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
            for poke in jsonResult {
                var tempPokemon = Pokemon()
                var index: Int = 0
                if let id = poke["pokemon"] as? Int {
                    for (i, pokemon) in pokeData.enumerate() {
                        if pokemon.id == id {
                            tempPokemon = pokemon
                            index = i
                            break
                        }
                    }
                }
                if let multi = poke["multiplier"] as? Float {
                    tempPokemon.evolutionMultiplier = multi
                }
                else {
                    tempPokemon.evolutionMultiplier = nil
                }
                pokeData[index] = tempPokemon
            }
            return pokeData
        }
        catch {
            print("PokeData: \(error)")
        }
    }
    catch {
        print("PokeData: \(error)")
    }
    
    return []
}

private func lvlInfo(pokeData: [Pokemon]) -> [Pokemon] {
    let file3 = NSBundle.mainBundle().pathForResource("pokelevel", ofType: "json")
    //let url3 = URL(fileURLWithPath: file3!)
    
    var pokeData = pokeData
    
    do {
        //let jsonData = try Data(contentsOf: url3, options: .dataReadingMappedIfSafe)
        let jsonData = try NSData(contentsOfFile: file3!, options: .DataReadingMappedIfSafe)
        do {
            let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
            for poke in jsonResult {
                var tempPokemon = Pokemon()
                var index: Int = 0
                if let id = poke["number"] as? Int {
                    for (i, pokemon) in pokeData.enumerate() {
                        if pokemon.id == id {
                            tempPokemon = pokemon
                            index = i
                            break
                        }
                    }
                }
                if let tier = poke["tier"] as? String {
                    tempPokemon.tier = tier
                }
                if let pow = poke["powerup"] as? Int {
                    tempPokemon.powerCP = pow
                }
                pokeData[index] = tempPokemon
            }
            return pokeData
        }
        catch{
            print(error)
        }
    }
    catch {
        print(error)
    }
    return []

}

private func pass1() -> [Pokemon] {
    
    var pokemonList: [Pokemon] = []
    
    pokemonList = baseInfo()
    
    pokemonList = moreInfo(pokemonList)
    
    pokemonList = evolInfo(pokemonList)
    
    pokemonList = lvlInfo(pokemonList)
    
    return pokemonList
    
}

private func pass2(pokeData: [Pokemon]) -> [Pokemon] {
    
    let file1 = NSBundle.mainBundle().pathForResource("pokemon", ofType: "json")
    //let url1 = URL(fileURLWithPath: file1!)
    
    var pokeData = pokeData
    
    do {
        //let jsonData = try Data(contentsOf: url1, options: .dataReadingMappedIfSafe)
        let jsonData = try NSData(contentsOfFile: file1!, options: .DataReadingMappedIfSafe)
        do {
            //let jsonResult: NSArray = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [NSDictionary]
            let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
            for poke in jsonResult {
                
                var tempPokemon = Pokemon()
                var index: Int = 0
                
                if let id = poke["Number"] as? String {
                    for (i, pokemon) in pokeData.enumerate() {
                        if pokemon.id == Int(id)! {
                            tempPokemon = pokemon
                            index = i
                            break
                        }
                    }
                }
                if let nextEvol = poke["Next evolution(s)"] as? [NSDictionary] {
                    for evol in nextEvol {
                        if let id = evol["Number"] as? String {
                            for (i, pokemon) in pokeData.enumerate() {
                                if pokemon.id == Int(id)! {
                                    tempPokemon.nextEvolution.append(pokeData[i])
                                    break
                                }
                            }
                        }
                    }
                }
                if let nextEvol = poke["Previous evolution(s)"] as? [NSDictionary] {
                    for evol in nextEvol {
                        if let id = evol["Number"] as? String {
                            for (i, pokemon) in pokeData.enumerate() {
                                if pokemon.id == Int(id)! {
                                    tempPokemon.previousEvolution.append(pokeData[i])
                                    break
                                }
                            }
                        }
                    }
                }
                pokeData[index] = tempPokemon
            }
            return pokeData
        }
        catch {
            print("\(error)")
        }
    }
    catch {
        print("\(error)")
    }
    return pokeData
}

public class PokeData {
    
    var pokemon: [Pokemon] = []
    var trainerLevel: Int = 1 {
        didSet {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(trainerLevel, forKey: "trainerLevel")
        }
    }
    var levelInfo: [Double] = [0.094, 0.16639787, 0.21573247, 0.25572005, 0.29024988,
                               0.3210876, 0.34921268, 0.37523559, 0.39956728, 0.4225,
                               0.44310755, 0.46279839, 0.48168495, 0.49985844, 0.51739395,
                               0.53435433, 0.55079269, 0.56675452, 0.58227891, 0.5974, 0.61215729,
                               0.62656713, 0.64065295, 0.65443563, 0.667934, 0.68116492,
                               0.69414365, 0.70688421, 0.71939909, 0.7317, 0.73776948,
                               0.74378943, 0.74976104, 0.75568551, 0.76156384, 0.76739717,
                               0.7731865, 0.77893275, 0.784637, 0.7903]

    init() {
        populatePokemonDS()
        print(levelInfo)
    }
    
    private func populatePokemonDS() {
        var pokeList: [Pokemon]
        pokeList = pass1()
        pokeList = pass2(pokeList)
        pokemon = pokeList
    }
    
    
    public func getPokemon(withID id: Int) -> Pokemon? {
        for poke in pokemon {
            if poke.id == id {
                return poke
            }
        }
        return nil
    }
    
}

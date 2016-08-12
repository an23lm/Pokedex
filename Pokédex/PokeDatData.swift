//
//  PokeDatData.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 10/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import Foundation

public class PokeData {
    var trainerLevel: Int = 1 {
        didSet {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                let defaults = NSUserDefaults.standardUserDefaults()
                defaults.setInteger(self.trainerLevel, forKey: "trainerLevel")
            })
        }
    }
    var pokemon: [Pokemon] = []
    var levelInfo: [Double] = [0.094, 0.16639787, 0.21573247, 0.25572005, 0.29024988,
                               0.3210876, 0.34921268, 0.37523559, 0.39956728, 0.4225,
                               0.44310755, 0.46279839, 0.48168495, 0.49985844, 0.51739395,
                               0.53435433, 0.55079269, 0.56675452, 0.58227891, 0.5974, 0.61215729,
                               0.62656713, 0.64065295, 0.65443563, 0.667934, 0.68116492,
                               0.69414365, 0.70688421, 0.71939909, 0.7317, 0.73776948,
                               0.74378943, 0.74976104, 0.75568551, 0.76156384, 0.76739717,
                               0.7731865, 0.77893275, 0.784637, 0.7903]
    
    init() {
        parsePokeData()
    }
    
    private func parsePokeData() {
        var pd = pass1()
        pd = pass2(pd)
        pokemon = pd
        //printList(pokemon)
    }
    
    public func getPokemon(withID id: Int) -> Pokemon? {
        for item in pokemon {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
    private func pass1() -> [Pokemon] {
        
        var baseInfoPokemonList: [Pokemon] = []
        
        let file = NSBundle.mainBundle().pathForResource("Poke", ofType: "json")
        
        do {
            let data = try NSData(contentsOfFile: file!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            do {
                let jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as! [NSDictionary]
                for poke in jsonData {
                    var tempPokemon: Pokemon = Pokemon()
                    if let id = poke["number"] as? Int {
                        tempPokemon.id = id
                        print(id)
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
                    if let multi = poke["multiplier"] as? Float {
                        tempPokemon.evolutionMultiplier = multi
                    }
                    else {
                        tempPokemon.evolutionMultiplier = nil
                    }
                    if let tier = poke["tier"] as? String {
                        tempPokemon.tier = tier
                    }
                    if let pow = poke["powerup"] as? Int {
                        tempPokemon.powerCP = pow
                    }
                    if let primary = poke["primaryColor"] as? String {
                        print(primary)
                        tempPokemon.primaryColor = UIColor.colorWithHexString(hexString: primary)
                    }
                    if let secondary = poke["secondaryColor"] as? String {
                        print(secondary)
                        tempPokemon.secondaryColor = UIColor.colorWithHexString(hexString: secondary)
                    }
                    if let text = poke["textColor"] as? String {
                        print(text)
                        tempPokemon.tertiaryColor = UIColor.colorWithHexString(hexString: text)
                    }
                    if let egg = poke["pokeegg"] as? String {
                        tempPokemon.eggDistance = Int(egg)
                    }
                    else {
                        tempPokemon.eggDistance = nil
                    }
                    baseInfoPokemonList.append(tempPokemon)
                }
                return baseInfoPokemonList
            }
            catch {
                print("Data to JSON conversion error: \(error)")
            }
        }
        catch {
            print("File to data conversion error: \(error)")
        }
        return []
    }
    
    private func pass2(pokeData: [Pokemon]) -> [Pokemon] {
        
        let file = NSBundle.mainBundle().pathForResource("Poke", ofType: "json")
        
        var pokeData = pokeData
        
        do {

            let jsonData = try NSData(contentsOfFile: file!, options: .DataReadingMappedIfSafe)
            do {
            
                let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
                
                for poke in jsonResult {
            
                    var tempPokemon = Pokemon()
                    var index: Int = 0
                    
                    if let id = poke["number"] as? Int {
                        for (i, pokemon) in pokeData.enumerate() {
                            if pokemon.id == Int(id) {
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
}

extension UIColor {
    
    static func colorWithHexString (hexString hex: String) -> UIColor {
        var cString: String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            let index = cString.startIndex.advancedBy(1)
            cString = cString.substringFromIndex(index)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.grayColor()
        }
        
        let index = cString.startIndex.advancedBy(2)
        var range = cString.startIndex..<index
        let rString = cString.substringWithRange(range)
        range = index..<(index.advancedBy(2))
        let gString = cString.substringWithRange(range)
        range = index..<(index.advancedBy(2))
        let bString = cString.substringWithRange(range)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
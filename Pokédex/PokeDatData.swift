//
//  PokeDatData.swift
//  Pokédex
//
//  Created by Ansèlm Joseph on 10/08/16.
//  Copyright © 2016 an23lm. All rights reserved.
//

import Foundation
import UIKit

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
    var attacks: [Attack] = []
    var typeAdvantage: [TypeAdvantage] = []
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
        parseAttack()
        parseTypeAdvantage()
    }
    
    private func parsePokeData() {
        var pd = pass1()
        pd = pass2(pd)
        //pd = parseDmg(pd)
        pokemon = pd
    }
    
    public func getPokemon(withID id: Int) -> Pokemon? {
        for item in pokemon {
            if item.id == id {
                return item
            }
        }
        return nil
    }
    
    public func getAttack(withName name: String) -> Attack? {
        for att in attacks {
            if att.move == name {
                return att
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
                        //print(id)
                    }
                    if let name = poke["Name"] as? String {
                        tempPokemon.name = name
                    }
                    if let classification = poke["Classification"] as? String {
                        tempPokemon.classification = classification
                    }
                    if let type1 = poke["Type I"] as? [String] {
                        for type in type1 {
                            let poketype: Type = Type.getType(fromString: type)
                            tempPokemon.type.append(poketype)
                        }
                    }
                    if let type2 = poke["Type II"] as? [String] {
                        for type in type2 {
                            let poketype: Type = Type.getType(fromString: type)
                            tempPokemon.type.append(poketype)
                        }
                    }
                    if let weekness = poke["Weaknesses"] as? [String] {
                        for type in weekness {
                            let poketype: Type = Type.getType(fromString: type)
                            tempPokemon.weekness.append(poketype)
                        }
                    }
                    if let attacks = poke["Fast Attack(s)"] as? [String] {
                        for att in attacks {
                            if att != "" {
                                tempPokemon.attacks.append(att)
                            }
                        }
                    }
                    if let special = poke["Charge Attack(s)"] as? [String] {
                        //print(special)
                        for att in special {
                            if att != "" {
                                tempPokemon.specialAttacks.append(att)
                            }
                        }
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
                        tempPokemon.primaryColor = UIColor.colorWithHexString(hexString: primary)
                    }
                    if let secondary = poke["secondaryColor"] as? String {
                        tempPokemon.secondaryColor = UIColor.colorWithHexString(hexString: secondary)
                    }
                    if let text = poke["textColor"] as? String {
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
    
    private func parseAttack() {
        let file = NSBundle.mainBundle().pathForResource("PokeAttacks", ofType: "json")
        
        do {
            
            let jsonData = try NSData(contentsOfFile: file!, options: .DataReadingMappedIfSafe)
            do {
                
                let jsonResult: NSArray = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
                for item in jsonResult {
                    var tempAttack = Attack()
                    if let move = item["Move"] as? String {
                        tempAttack.move = move
                    }
                    if let type = item["Type"] as? String {
                        tempAttack.type = Type.getType(fromString: type)
                    }
                    if let category = item["Category"] as? String {
                        if category == "Charge" {
                            tempAttack.isCharge = true
                        }
                    }
                    if let pow = item["Power"] as? Int {
                        tempAttack.power = pow
                    }
                    if let sec = item["Sec"] as? Float {
                        tempAttack.sec = sec
                    }
                    if let dps = item["DPS"] as? Float {
                        tempAttack.dps = dps
                    }
                    if let eng = item["Energy"] as? Int {
                        tempAttack.energy = eng
                    }
                    attacks.append(tempAttack)
                }
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
    
    func parseDmg(pokemon: [Pokemon]) -> [Pokemon] {
        let file = NSBundle.mainBundle().pathForResource("Pokemax", ofType: "json")
        do {
            let jsonData = try NSData(contentsOfFile: file!, options: .DataReadingMappedIfSafe)
            do {
                var pokearr: [Pokemon] = []
                let result = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
                for item in result {
                    var temp: Pokemon! = nil
                    for poke in pokemon {
                        if poke.name == (item["name"] as! String) {
                            temp = poke
                            break
                        }
                    }
                    if let dmg = item["val"] as? Float {
                        temp.maxDmgTaken = dmg
                    }
                    pokearr.append(temp)
                }
                return pokearr
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
        return []
    }
    
    func parseTypeAdvantage() {
        let file = NSBundle.mainBundle().pathForResource("TypeAdv", ofType: "json")
        do {
            let jsonData = try NSData(contentsOfFile: file!, options: .DataReadingMappedIfSafe)
            do {
                let result = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! [NSDictionary]
                for item in result {
                    var temp = TypeAdvantage()
                    if let type = item["Type"] as? String {
                        temp.type = Type.getType(fromString: type)
                    }
                    if let adv = item["Advantage"] as? [String] {
                        for type in adv {
                            temp.advantage.append(Type.getType(fromString: type))
                        }
                    }
                    if let dis = item["Disadvantage"] as? [String] {
                        for type in dis {
                            temp.disadvantage.append(Type.getType(fromString: type))
                        }
                    }
                    typeAdvantage.append(temp)
                }
            }
            catch {
                print(error)
            }
        }
        catch {
            print(error)
        }
    }
    
    func getTypeAdvantage(forType type: Type) -> TypeAdvantage? {
        for item in typeAdvantage {
            if item.type == type {
                return item
            }
        }
        return nil
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
        
        var index = cString.startIndex.advancedBy(2)
        var range = cString.startIndex..<index
        let rString = cString.substringWithRange(range)
        range = index..<(index.advancedBy(2))
        let gString = cString.substringWithRange(range)
        index = index.advancedBy(2)
        range = index..<(index.advancedBy(2))
        let bString = cString.substringWithRange(range)
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
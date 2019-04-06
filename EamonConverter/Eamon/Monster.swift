//
//  Monster.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 4/1/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

struct CodableMonster: Codable {
    
    var id: Int
    var name: String
    var description: String
    var hardiness, agility, friendliness, courage: Int
    var defense_odds, room_id, weight, armor_class: Int
    var weapon_id, offense_odds, weapon_dice, weapon_sides: Int
    
    init(_ monster: Monster) {
        self.id = monster.id
        self.name = monster.name
        self.description = monster.description
        self.hardiness = monster.hardiness
        self.agility = monster.agility
        self.friendliness = monster.friendliness
        self.courage = monster.courage
        self.defense_odds = monster.defensiveOdds
        self.room_id = monster.roomId
        self.weight = monster.weight
        self.armor_class = monster.armor
        self.offense_odds = monster.hitOdds
        self.weapon_id = monster.weaponId
        self.weapon_dice = monster.weaponDice
        self.weapon_sides = monster.weaponSides
        
    }
}

class Monster {
    
    private var _id = 0
    private var _name = "Grue"
    private var _desc = "You see the Grue: a sinister, lurking presence in the dark places of the earth. Its favorite diet is adventurers, but its insatiable appetite is tempered by its fear of light."
    private var _attributes: [Int]
    
    init() {
        _attributes = [0,0,0,0,0,0,0,0,0,0,0,0]
    }
    
    init(id: Int, name: String, desc: String, attributes: [Int]) {
        _id = id
        _name = name.capitalized
        _desc = desc
        _attributes = attributes
    }
    
    var id: Int {
        get { return _id }
        set { _id = newValue }
    }
    
    var name: String {
        get { return _name }
        set { _name = newValue }
    }
    
    var description: String {
        get { return _desc.collapseWhitespace() }
        set { _desc = newValue }
    }
    
    var hardiness: Int {
        get { return _attributes[0] }
        set { _attributes[0] = newValue }
    }
    
    var agility: Int {
        get { return _attributes[1] }
        set { _attributes[1] = newValue }
    }
    
    var friendliness: Int {
        get { return _attributes[2] }
        set { _attributes[2] = newValue }
    }
    
    var courage: Int {
        get { return _attributes[3] }
        set { _attributes[2] = newValue }
    }
    
    var roomId: Int {
        get { return _attributes[4] }
        set { _attributes[5] = newValue }
    }
    
    var weight: Int {
        get { return _attributes[5] }
        set { _attributes[5] = newValue }
    }
    
    var defensiveOdds: Int {
        get { return _attributes[6] }
        set { _attributes[6] = newValue }
    }
    
    var armor: Int {
        get { return _attributes[7] }
        set { _attributes[7] = newValue }
    }
    
    var weaponId: Int {
        get { return _attributes[8] }
        set { _attributes[8] = newValue }
    }
    
    var hitOdds: Int {
        get { return _attributes[9] }
        set { _attributes[9] = newValue }
    }
    
    var weaponDice: Int {
        get { return _attributes[10] }
        set { _attributes[10] = newValue }
    }
    
    var weaponSides: Int {
        get { return _attributes[11] }
        set { _attributes[11] = newValue }
    }
    
    var codable: CodableMonster {
        get { return CodableMonster(self) }
        set { }
    }
}

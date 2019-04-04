//
//  Dungeon.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 3/29/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

struct CodableDungeon: Codable {
    var name: String
    var number_of_directions: Int
    var rooms: [CodableRoom]
    var artifacts: [CodableArtifact]
    var effects: [CodableEffect]
    var monsters: [CodableMonster]

    init(_ dungeon: Dungeon) {
        self.name = dungeon.name
        self.number_of_directions = dungeon.directions
        self.rooms = dungeon.codableRooms
        self.artifacts = dungeon.codableArtifacts
        self.effects = dungeon.codableEffects
        self.monsters = dungeon.codableMonsters
    }
}

class Dungeon {
    // expected file names for data
    private let _EamonNameFile = "eamon.name.txt"
    private let _EamonDescFile = "eamon.desc.txt"
    private let _EamonRoomNamesFile = "eamon.room.name.txt"
    private let _EamonRoomsFile = "eamon.rooms.txt"
    private let _EamonArtifactsFile = "eamon.artifacts.txt"
    private let _EamonMonstersFile = "eamon.monsters.txt"
    
    private var _name = "Untitled"
    private var _directions = 6
    private var _numberOfRooms = 0
    private var _numberOfArtifacts = 0
    private var _numberOfEffects = 0
    private var _numberOfMonsters = 0
    private var _desc: ApplesoftDB
    
    private var _rooms = [Room]()
    private var _artifacts = [Artifact]()
    private var _effects = [Effect]()
    private var _monsters = [Monster]()
    
    init() {
        _desc = ApplesoftDB(_EamonDescFile, recordLength: 256, asRaw: false)
        loadEamonName(_EamonNameFile)
        loadQuantities(_EamonDescFile)
        if _numberOfRooms > 0 { loadRooms(namesFile: _EamonRoomNamesFile, connectionsFile: _EamonRoomsFile, desc: _desc) }
        if _numberOfArtifacts > 0 { loadArtifacts(artifactsFile: _EamonArtifactsFile, desc: _desc) }
        if _numberOfEffects > 0 { loadEffects(desc: _desc) }
        if _numberOfMonsters > 0 { loadMonsters(monstersFile: _EamonMonstersFile, desc: _desc) }
    }
    
    private func loadEamonName(_ file: String) {
        let tmpDB = ApplesoftDB(file, recordLength: 0, asRaw: true)
        let tmpInputs = tmpDB.records[0].inputs(2)
        if tmpInputs != nil {
            _name = tmpInputs![0]
            if Int(tmpInputs![1]) == nil { _directions = 6 } else { _directions = Int(tmpInputs![1])! }
        }
    }
    
    private func loadQuantities(_ file: String) {
        let tmpDB = ApplesoftDB(file, recordLength: 0, asRaw: true)
        let tmpInputs = tmpDB.records[0].inputs(4)
        if tmpInputs != nil {
            if Int(tmpInputs![0]) != nil { _numberOfRooms = Int(tmpInputs![0])! }
            if Int(tmpInputs![1]) != nil { _numberOfArtifacts = Int(tmpInputs![1])! }
            if Int(tmpInputs![2]) != nil { _numberOfEffects = Int(tmpInputs![2])! }
            if Int(tmpInputs![3]) != nil { _numberOfMonsters = Int(tmpInputs![3])! }
        }
    }
    
    private func loadRooms(namesFile: String, connectionsFile: String, desc: ApplesoftDB) {
        let names = ApplesoftDB(namesFile, recordLength: 64, asRaw: false)
        let connections = ApplesoftDB(connectionsFile, recordLength: 64, asRaw: true)
        _rooms.append(Room()) // add a dummy room
        for i in 1..._numberOfRooms {
            let roomName = names.records[i]
            let roomDesc = desc.records[i]
            let roomExitsStr = connections.records[i].inputs(_directions)!
            var roomExits = [Int]()
            for dir in roomExitsStr {
                roomExits.append(Int(dir)!)
            }
            let roomLight = true // assuming for now
            let newRoom = Room(id: i, name: roomName, desc: roomDesc, exits: roomExits, light: roomLight)
            _rooms.append(newRoom)
        }
    }
    
    private func loadArtifacts(artifactsFile: String, desc: ApplesoftDB) {
        let offset = 100
        let artifactsDB = ApplesoftDB(artifactsFile, recordLength: 128, asRaw: true)
        _artifacts.append(Artifact()) // add a dummy artifact
        for i in 1..._numberOfArtifacts {
            var artifact = artifactsDB.records[i].inputs(5)!
            let artifactName = artifact[0]
            if Int(artifact[2])! > 1 { artifact = artifactsDB.records[i].inputs(9)! }
            artifact.remove(at: 0)
            let artifactDesc = desc.records[i + offset]
            var artifactAttributes = [Int]()
            for attrib in artifact {
                artifactAttributes.append(Int(attrib)!)
            }
            let newArtifact = Artifact(id: i, name: artifactName, desc: artifactDesc, attributes: artifactAttributes)
            _artifacts.append(newArtifact)
        }
    }
    
    private func loadEffects(desc: ApplesoftDB) {
        let offset = 200
        _effects.append(Effect()) // dummy effect
        for i in 1..._numberOfEffects {
            _effects.append(Effect(id: i, desc: desc.records[i + offset]))
        }
    }
    
    private func loadMonsters(monstersFile: String, desc: ApplesoftDB) {
        let offset = 300
        let monstersDB = ApplesoftDB(monstersFile, recordLength: 128, asRaw: true)
        _monsters.append(Monster()) // add a dummy Monster
        for i in 1..._numberOfMonsters {
            var monster = monstersDB.records[i].inputs(13)!
            let monsterName = monster[0]
            monster.remove(at: 0)
            let monsterDesc = desc.records[i + offset]
            var monsterAttributes = [Int]()
            for attrib in monster {
                monsterAttributes.append(Int(attrib)!)
            }
            let newMonster = Monster(id: i, name: monsterName, desc: monsterDesc, attributes: monsterAttributes)
            _monsters.append(newMonster)
        }
    }
    
    var codableRooms: [CodableRoom] {
        get {
            var codableRooms = [CodableRoom]()
            for room in _rooms {
                if room.id != 0 { codableRooms.append(room.codable) }
            }
            return codableRooms
        }
        set { }
    }
    
    var codableArtifacts: [CodableArtifact] {
        get {
            var codableArtifacts = [CodableArtifact]()
            for artifact in _artifacts {
                if artifact.id != 0 { codableArtifacts.append(artifact.codable) }
            }
            return codableArtifacts
        }
        set { }
    }
    
    var codableEffects: [CodableEffect] {
        get {
            var codableEffects = [CodableEffect]()
            for effect in _effects {
                if effect.id != 0 { codableEffects.append(effect.codable) }
            }
            return codableEffects
        }
        set { }
    }
    
    var codableMonsters: [CodableMonster] {
        get {
            var codableMonsters = [CodableMonster]()
            for monster in _monsters {
                if monster.id != 0 { codableMonsters.append(monster.codable) }
            }
            return codableMonsters
        }
        set { }
    }
    
    var name: String {
        get { return _name.capitalized }
        set { }
    }

    var directions: Int {
        get { return _directions }
        set { _directions = newValue }
    }

    var description: String {
        get {
            var description: String
            description = "\(self.name) [🧭\(_directions)]\n"
            description += "[🏰\(_numberOfRooms) | 💎\(_numberOfArtifacts) | ✨\(_numberOfEffects) | 👾\(_numberOfMonsters)]\n"
            return description
        }
        set { }
    }

    var codable: CodableDungeon {
        get { return CodableDungeon(self) }
        set { }
    }
}

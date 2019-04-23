//
//  Room.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 3/29/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

struct CodableRoom: Codable {
    var id: Int
    var name,description: String
    var n,s,e,w,u,d,ne,nw,se,sw: Int?
    var light: Int
    
    init(_ room: Room) {
        self.id = room.id
        self.name = room.name
        self.description = room.description
        self.n = room.north
        self.s = room.south
        self.e = room.east
        self.w = room.west
        self.u = room.up
        self.d = room.down
        self.ne = room.northeast
        self.nw = room.northwest
        self.se = room.southeast
        self.sw = room.southwest
        self.light = 1
        if room.light == false { self.light = 0 }
    }
}

class Room {
    
    private var _id = 0
    private var _name = "in an empty room."
    private var _desc = "This is an empty room."
    private var _exits = [Int?]()
    private var _light = true
    
    init() {
        _exits = [0,0,0,0,0,0]
    }
    
    init(id: Int, name: String, desc: String, exits: [Int], light: Bool) {
        _id = id
        _name = name
        _desc = desc
        if (exits.count == 6) || (exits.count == 10) {
            _exits = exits
        } else {
            _exits = [0,0,0,0,0,0,0,0,0,0]
            for i in 0..<exits.count {
                _exits[i] = exits[i]
            }
            print("WARNING:\nRoom #\(id) has only \(exits.count) directions. Defaulting to 10.\n")
        }
        _light = light
    }
    
    var id: Int {
        get { return _id }
        set { _id = newValue }
    }
    
    var name: String {
        get { return ("You are " + _name) }
        set { _name = newValue }
    }
    
    var description: String {
        get { return _desc.collapseWhitespace() }
        set { _desc = newValue }
    }
    
    var north: Int? {
        get { return _exits[0] }
        set { _exits[0] = newValue }
    }
    
    var south: Int? {
        get { return _exits[1] }
        set { _exits[1] = newValue }
    }
    
    var east: Int? {
        get { return _exits[2] }
        set { _exits[2] = newValue }
    }
    
    var west: Int? {
        get { return _exits[3] }
        set { _exits[3] = newValue }
    }
    
    var up: Int? {
        get { return _exits[4] }
        set { _exits[4] = newValue }
    }
    
    var down: Int? {
        get { return _exits[5] }
        set { _exits[5] = newValue }
    }
    
    var northeast: Int? {
        get {
            if _exits.count < 7 { return nil }
            return _exits[6]
        }
        set { _exits[6] = newValue }
    }
    
    var northwest: Int? {
        get {
            if _exits.count < 8 { return nil }
            return _exits[7]
        }
        set { _exits[7] = newValue }
    }
    
    var southeast: Int? {
        get {
            if _exits.count < 9 { return nil }
            return _exits[8]
        }
        set { _exits[8] = newValue }
    }
    
    var southwest: Int? {
        get {
            if _exits.count < 10 { return nil }
            return _exits[9]
        }
        set { _exits[9] = newValue }
    }
    
    var light: Bool {
        get { return _light }
        set { _light = newValue }
    }
    
    var codable: CodableRoom {
        get { return CodableRoom(self) }
        set { }
    }
    
}

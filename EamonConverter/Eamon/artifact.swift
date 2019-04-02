//
//  artifact.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 4/1/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

struct CodableArtifact: Codable {
    
    var name: String
    var description: String
    var value: Int
    var type: Int
    var weight: Int
    var room_id: Int
    var field5: Int?
    var field6: Int?
    var field7: Int?
    var field8: Int?
    
    init(_ artifact: Artifact) {
        self.name = artifact.name
        self.description = artifact.description
        self.value = artifact.value
        self.type = artifact.type
        self.weight = artifact.weight
        self.room_id = artifact.roomId
        self.field5 = artifact.attributes[4]
        self.field6 = artifact.attributes[5]
        self.field7 = artifact.attributes[6]
        self.field8 = artifact.attributes[7]
    }
}

class Artifact {
    
    private var _id = 0
    private var _name = "dummy"
    private var _desc = "You see a sad-looking dummy artifact here without form or substance."
    private var _attributes: [Int?]
    
    init() {
        _attributes = [0,0,0,0]
    }
    
    init(id: Int, name: String, desc: String, attributes: [Int?]) {
        _id = id
        _name = name
        _desc = desc
        _attributes = attributes
    }
    
    var id: Int {
        get { return _id }
        set { _id = newValue }
    }
    
    var name: String {
        get { return _name.lowercased() }
        set { _name = newValue }
    }
    
    var description: String {
        get { return _desc.collapseWhitespace() }
        set { _desc = newValue }
    }
    
    var value: Int {
        get { return _attributes[0]! }
        set { _attributes[0] = newValue }
    }
    
    var type: Int {
        get { return _attributes[1]! }
        set { _attributes[1] = newValue }
    }
    
    var weight: Int {
        get { return _attributes[2]! }
        set { _attributes[2] = newValue }
    }
    
    var roomId: Int {
        get { return _attributes[3]! }
        set { _attributes[3] = newValue }
    }
    
    var attributes: [Int?] {
        get {
            var attribs = [Int?]()
            for _ in 0..<8 { attribs.append(nil) }
            for i in 0..<_attributes.count {
                attribs[i] = _attributes[i]
            }
            return attribs
        }
        set { }
    }
    
    var codable: CodableArtifact {
        get { return CodableArtifact(self) }
        set { }
    }
}

//
//  Effect.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 3/31/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

struct CodableEffect: Codable {
    var id: Int
    var text: String
    
    init(_ effect: Effect) {
        self.id = effect.id
        self.text = effect.description
    }
}

class Effect {
    
    private var _id = 0
    private var _desc = "Nothing happens."
    
    init() {
    }
    
    init(id: Int, desc: String) {
        _id = id
        _desc = desc
    }
    
    var id: Int {
        get { return _id }
        set { _id = newValue }
    }
    
    var description: String {
        get { return _desc.collapseWhitespace() }
        set { _desc = newValue }
    }
    
    var codable: CodableEffect {
        get { return CodableEffect(self) }
        set { }
    }
    
}


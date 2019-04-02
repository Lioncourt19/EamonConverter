//
//  Intro.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 4/1/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

class Intro {

    private var _rawData = String()

    init (_ path: String) {
        do {
            self._rawData = try String(contentsOfFile: path, encoding:.ascii)
        } catch let error {
            print ("\(path) not found.")
        }
    }

    var text: String {
        get {
            var text = String()
            let components = _rawData.components(separatedBy: "\"")
            for component in components {
                if !component.contains("PRINT") { text += "\(component)\n" }
            }
            return text
        }
        set { }
    }

}

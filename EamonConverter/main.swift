//
//  main.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 3/16/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

let _appTitle = "EamonConverter 🧙🏽‍♀️"
let _author = "Josh de Lioncourt"
let _versionMajor = 0
let _versionMinor = 6
let _versionRevision = 5

print("\(_appTitle)")
print("\tby \(_author)")
print("\tVersion \(_versionMajor).\(_versionMinor).\(_versionRevision)\n");

var dgn = Dungeon()

let jsonEncoder = JSONEncoder()
let currentDirURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
var url: URL

do {
    let jsonRooms = try jsonEncoder.encode(dgn.codableRooms)
    url = URL(fileURLWithPath: "rooms.json", relativeTo: currentDirURL)
    try jsonRooms.write(to: url)
}
catch {
    print("Error: Can't encode/write rooms.json")
}

do {
    let jsonArtifacts = try jsonEncoder.encode(dgn.codableArtifacts)
    url = URL(fileURLWithPath: "artifacts.json", relativeTo: currentDirURL)
    try jsonArtifacts.write(to: url)
}
catch {
    print("Error: Can't encode/write artifacts.json")
}

do {
    let jsonEffects = try jsonEncoder.encode(dgn.codableEffects)
    url = URL(fileURLWithPath: "effects.json", relativeTo: currentDirURL)
    try jsonEffects.write(to: url)
}
catch {
    print("Error: Can't encode/write effects.json")
}

do {
    let jsonMonsters = try jsonEncoder.encode(dgn.codableMonsters)
    url = URL(fileURLWithPath: "monsters.json", relativeTo: currentDirURL)
    try jsonMonsters.write(to: url)
}
catch {
    print("Error: Can't encode/write monsters.json")
}

do {
    let jsonDungeon = try jsonEncoder.encode(dgn.codable)
    url = URL(fileURLWithPath: "dungeon.json", relativeTo: currentDirURL)
    try jsonDungeon.write(to: url)
}
catch {
    print("Error: Can't encode/write dungeon.json")
}

do {
    let intro = Intro("eamon.intro.txt")
    if intro.text.count > 1 {
        try intro.text.write(toFile: "intro.txt", atomically: false, encoding: String.Encoding.utf8)
    }
} catch {
}

print(dgn.description)


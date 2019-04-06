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
let _versionMinor = 7
let _versionRevision = 0

print("\(_appTitle)")
print("\tby \(_author)")
print("\tVersion \(_versionMajor).\(_versionMinor).\(_versionRevision)\n");

var dgn = Dungeon()

let jsonEncoder = JSONEncoder()
let currentDirURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
let destinationPathURL = currentDirURL.appendingPathComponent("json", isDirectory: true)
var url = destinationPathURL

do {
    if !FileManager.default.fileExists(atPath: destinationPathURL.path) {
        try FileManager.default.createDirectory(at: destinationPathURL, withIntermediateDirectories: false, attributes:nil)
    }
} catch {
    print("Could not create directory \(destinationPathURL)")
    exit(1)
}

do {
    // rooms
    let jsonRooms = try jsonEncoder.encode(dgn.codableRooms)
    url = URL(fileURLWithPath: "rooms.json", relativeTo: destinationPathURL)
    try jsonRooms.write(to: url)
    // artifacts
    let jsonArtifacts = try jsonEncoder.encode(dgn.codableArtifacts)
    url = URL(fileURLWithPath: "artifacts.json", relativeTo: destinationPathURL)
    try jsonArtifacts.write(to: url)
    // effects
    let jsonEffects = try jsonEncoder.encode(dgn.codableEffects)
    url = URL(fileURLWithPath: "effects.json", relativeTo: destinationPathURL)
    try jsonEffects.write(to: url)
    // monsters
    let jsonMonsters = try jsonEncoder.encode(dgn.codableMonsters)
    url = URL(fileURLWithPath: "monsters.json", relativeTo: destinationPathURL)
    try jsonMonsters.write(to: url)
    // dungeon
    let jsonDungeon = try jsonEncoder.encode(dgn.codable)
    url = URL(fileURLWithPath: "dungeon.json", relativeTo: destinationPathURL)
    try jsonDungeon.write(to: url)
}
catch {
    print("Error: Can't encode/write \(url)")
}

do {
    let intro = Intro("eamon.intro.txt")
    if intro.text.count > 1 {
        try intro.text.write(toFile: "intro.txt", atomically: false, encoding: String.Encoding.utf8)
    }
} catch {
}

print(dgn.description)


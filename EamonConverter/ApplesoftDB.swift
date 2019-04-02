//
//  ApplesoftDB.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 3/28/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

class ApplesoftDB {

    private var _rawData = String()
    private let _recLength: Int
    private var _recs = [String]()

    /*
     * init()
     *
     * path = path to an Applesoft Basic database text file with records of a fixed length
     * recordLength = the fixed record length of each entry in the Applesoft database file
     * asRaw = boolean for how to process the records.
     *      true = no processing is done initially
     *      false = each record is processed as a single string entry
     */
    init (_ path: String, recordLength: Int, asRaw: Bool) {
        do {
            _rawData = try String(contentsOfFile: path, encoding:.ascii)
        } catch let error {
            print("Error: No such file \(path)")
            _recLength = 0
            return
        }
        if recordLength > 0 {
            _recLength = recordLength
        } else {
            _recLength = _rawData.count
        }
        if asRaw == false {
            _recs = processStringRecords()
        } else {
            _recs = processRawRecords()
        }
    }

    /*
     *processStringRecords()
     * Applesoft databases processed as having single string records mark the end of each record in one of three ways:
     *      null character (ASCII 0)
     *      return character (ASCII 13)
     *      end of record reached (dependent upon record length)
     *
     * The start of the string in the record is marked with a quotation (")
     * Thus, a record may contain garbage data before, after, or both before/after the string itself.
     */
    private func processStringRecords() -> [String] {
        var origRecs = _rawData.group(of: _recLength)
        var newRecs = [String]()
        var tmpRec: String
        for rec in origRecs {
            tmpRec = ""
            var startOfRec = false
            var endOfRec = false
            for char in rec {
                endOfRec = false
                let charString = String(char)
                for codeUnit in charString.utf8 {
                    if codeUnit != 0 && codeUnit != 13 {
                        if startOfRec == true { tmpRec += charString }
                        if codeUnit == 34 { startOfRec = true }
                    } else {
                        if startOfRec == true {
                            endOfRec = true
                            break
                        }
                    }
                }
                if endOfRec == true { break }
            }
            newRecs.append(tmpRec)
        }
        return newRecs
    }

    /*
     * processRawRecords()
     *
     * This function is typically used for records which may contain mixed data (generally strings, numbers, or multiple ocmbinations of both separated by return characters)
     * These function preserves the structure of the valud data and discards garbage data.
     */
    private func processRawRecords() -> [String] {
        var origRecs = _rawData.group(of: _recLength)
        var newRecs = [String]()
        var tmpRec: String
        for rec in origRecs {
            tmpRec = ""
            var startOfRec = false
            var endOfRec = false
            for char in rec {
                startOfRec = true
                endOfRec = false
                let charString = String(char)
                for codeUnit in charString.utf8 {
                    if codeUnit != 0 {
                        if startOfRec == true { tmpRec += charString }
                    } else {
                        if startOfRec == true {
                            endOfRec = true
                            break
                        }
                    }
                }
                if endOfRec == true { break }
            }
            newRecs.append(tmpRec)
        }
        return newRecs
    }

    var records: [String] {
        get { return _recs }
        set { }
    }

}

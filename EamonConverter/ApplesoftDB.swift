//
//  ApplesoftDB.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 3/28/19.
//  Copyright © 2019 Draconis Entertainment. All rights reserved.
//

import Foundation

extension String {
    func group(of n: Int) -> [String] {
        let chars = Array(self)
        return stride(from: 0, to: chars.count, by: n).map {
            String(chars[$0..<min($0+n, chars.count)])
        }
    }

    func inputs(_ quantity: Int) -> [String]? {
        var total = quantity
        let inputs = self.components(separatedBy: "\r")
        if inputs.count < total { return nil }
        var subset = [String]()
        for i in 0..<total {
            subset.append(inputs[i])
        }
        return subset
    }

    func collapseWhitespace() -> String {
        let stripped = self.components(separatedBy: .whitespaces)
        var result = ""

        for component in stripped {
            if component.count > 0 {
                result += component
                if component != stripped.last { result += " " }
            }
        }
        return result
    }
}

class ApplesoftDB {

    private var _rawData = String()
    private let _recLength: Int
    private var _recs = [String]()

    init (_ path: String, recordLength: Int, asRaw: Bool) {
        do {
            _rawData = try String(contentsOfFile: path, encoding:.ascii)
        } catch let error {
            // ‽ later
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

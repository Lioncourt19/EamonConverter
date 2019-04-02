//
//  String-extension.swift
//  EamonConverter
//
//  Created by Josh de Lioncourt on 4/2/19.
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

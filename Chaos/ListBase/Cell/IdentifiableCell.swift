//
//  IdentifiableCell.swift
//  Chaos
//
//  Created by john on 2023/4/17.
//

import Foundation

protocol IdentifiableCell {
    static func cellIdentifier() -> String
}

extension IdentifiableCell {
    static func cellIdentifier() -> String {
        return String(describing: self)
    }
}

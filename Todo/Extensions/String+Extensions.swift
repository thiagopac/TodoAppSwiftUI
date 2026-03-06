//
//  String+Extensions.swift
//  Todo
//
//  Created by Thiago Castro on 05/03/26.
//


import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

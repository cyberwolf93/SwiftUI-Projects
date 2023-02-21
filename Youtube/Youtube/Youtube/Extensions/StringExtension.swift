//
//  StringExtension.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 21/02/2023.
//

import Foundation

extension String {
    
    var localize: String {
        return NSLocalizedString(self, comment: "")
    }
}

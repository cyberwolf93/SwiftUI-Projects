//
//  UIImageExtension.swift
//  Youtube
//
//  Created by Ahmed Mohiy on 22/02/2023.
//

import UIKit
 
extension UIImage {
    static func load(name: String, with extension: String) -> UIImage {
        guard let url = Bundle.main.url(forResource: name, withExtension: `extension`) else {return UIImage()}
        do {
            let data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        }catch {
            return UIImage()
        }
    }
}

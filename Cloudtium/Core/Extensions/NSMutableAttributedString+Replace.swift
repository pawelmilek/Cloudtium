//
//  NSMutableAttributedString+Replace.swift
//  Cloudtium
//
//  Created by Pawel Milek on 7/18/23.
//

import Foundation

extension NSMutableAttributedString {

    func replace(_ findString: String,
                 attributes: [NSAttributedString.Key: Any]) {
        let ms = mutableString
        let range = ms.range(of: findString)
        addAttributes(attributes, range: range)
    }

}

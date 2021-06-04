//
//  StringExtensions.swift
//  ReduxNewsReader
//
//  Created by Mikhail Radaev on 30.05.2021.
//

import Foundation

public extension String {
    
    var htmlAsAttributedString: NSAttributedString? {
        let modifiedFont = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: 15\">%@</span>", self)
        let data = modifiedFont.data(using: .utf8) ?? Data()
        return try? NSAttributedString(
            data: data,
            options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
    }
}

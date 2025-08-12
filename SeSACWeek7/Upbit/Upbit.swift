//
//  Upbit.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

struct Upbit: Decodable {
    let market: String
    let korean_name: String
    let english_name: String
    
    var overView: String {
        "\(korean_name) | \(english_name)"
    }
}

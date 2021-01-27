//
//  Movie.swift
//  CinemaApp
//
//  Created by bnkwsr1 on 16.01.2021.
//

import Foundation
import SwiftyJSON


class Tag : ObservableObject, Codable, Identifiable {
    var idTags : String
    var tagName : String
}

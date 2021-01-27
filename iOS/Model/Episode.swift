//
//  Movie.swift
//  CinemaApp
//
//  Created by bnkwsr1 on 16.01.2021.
//

import Foundation
import SwiftyJSON


class Episode : ObservableObject, Codable, Identifiable {
    var episodeId : String
    var name : String
    var description : String
    var moviesId : String
    var director : String
    var stars : [String]
    var year : String
    var runtime : String
    var preview : String
    var images : [String]
    
    static func getEpisodes(data: Data) -> [Episode] {
        if let data = try? JSONDecoder().decode([Episode].self, from: data) {
            return data
        }
        
        return []
    }
}

//
//  Movie.swift
//  CinemaApp
//
//  Created by bnkwsr1 on 16.01.2021.
//

import Foundation
import SwiftyJSON


class Movie : ObservableObject, Codable, Identifiable {
    static func getMovies(data : Data) -> [Movie]{
        if let movie = try? JSONDecoder().decode([Movie].self, from: data) {
            return movie
        }
        
        return []
        
    }
    
    var movieId : String
    var name : String
    var description : String
    var age : String
    var images : [String]
    var poster : String
    var tags : [Tag]
}

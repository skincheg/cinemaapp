import Foundation
import Alamofire
import SwiftyJSON

class MainViewModel : ObservableObject {
    @Published var login : String = ""
    @Published var coverData : [Data] = []
    
    @Published var trendMovies : [Movie]  = []
    @Published var newMovies : [Movie]  = []
    @Published var forMeMovies : [Movie]  = []
    
    func loadCover(completion: @escaping (Bool) -> Void) {
        AF.request("http://cinema.areas.su/movies/cover", method: .get).responseData(completionHandler: { (res) in
            switch (res.result){
            case .success(let data):
                let json = try? JSON(data: data)
                if let jsonData = json {
                    if let url = URL(string: "http://cinema.areas.su/up/images/\(jsonData["backgroundImage"].stringValue)") {
                        if let dataImage = try? Data(contentsOf: url) {
                            self.coverData.append(dataImage)
                            if let urlForeground = URL(string: "http://cinema.areas.su/up/images/\(jsonData["foregroundImage"].stringValue)") {
                                if let dataImage = try? Data(contentsOf: urlForeground) {
                                    self.coverData.append(dataImage)
                                }
                            }
                            completion(true)
                        }
                    }
                    break
                }
                completion(false)
                break
            case .failure:
                completion(false)
                break
            }
        })
    }
    
    func getMovies(filter : FilmFilters, completion: @escaping (Bool) -> Void) {
        let params = ["filter" : filter.rawValue]
        
        AF.request("http://cinema.areas.su/movies", method: .get, parameters: params).responseData(completionHandler: { (res) in
            switch (res.result){
            case .success(let data):
                let movie = Movie.getMovies(data: data)
                
                switch filter {
                case .forMe:
                    self.forMeMovies = movie
                    break
                case .inTrend:
                    self.trendMovies = movie
                    break
                case .new:
                    self.newMovies = movie
                    break
                default:
                    break
                }
                
                break
            case .failure:
                completion(false)
                break
            }
        })
    }
    
    
    enum FilmFilters : String {
        case new,
             inTrend,
             forMe
    }
}

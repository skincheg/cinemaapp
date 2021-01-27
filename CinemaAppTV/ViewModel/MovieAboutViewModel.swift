import Foundation
import Alamofire
import SwiftyJSON

class MovieAboutViewModel : ObservableObject {
    public var token : String? {
        get {
            UserDefaults.standard.string(forKey: "token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    
    @Published var episodes : [Episode]?
    
    @Published var isShowingVideo = false
    
    func getMovie(movieId : String, onExit : @escaping (Bool) -> Void) {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization" : "Bearer \(token ?? "")",
        ]

        
        AF.request("http://cinema.areas.su/movies/\(movieId)/episodes", method: .get, headers: headers).responseData(completionHandler: { (res) in
            switch (res.result){
            case .success(let data):
                let episodes = Episode.getEpisodes(data: data)
                self.episodes = episodes
                break
            case .failure:
                print(res.result)
                break
            }
            
            onExit(true)
        })
    }
}

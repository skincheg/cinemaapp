import Foundation
import Alamofire
import SwiftyJSON

class AppViewModel : ObservableObject {
    public var token : String? {
        get {
            UserDefaults.standard.string(forKey: "token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    
    @Published var screen = "home"
    @Published var isLogged : Bool = false
    
    @Published var currentMovie : Movie?
    
    func checkUser(onExit : @escaping (Bool) -> Void) {
        
        var headers : HTTPHeaders = [
            "Accept": "application/json",
        ]
        
        if (token != nil) {
            headers.add(HTTPHeader(name: "Authorization", value: "Bearer \(token ?? "")"))
        }
    
        print(self.token)

        
        AF.request("http://cinema.areas.su/user", method: .get, headers: headers).responseData(completionHandler: { (res) in
            print(res.response?.statusCode)
            print(headers)
            
            switch (res.response?.statusCode) {
            case 200:
                self.isLogged = true
                break
            default:
                self.isLogged = false
                break
            }
            
            onExit(self.isLogged)
        })
    }
}

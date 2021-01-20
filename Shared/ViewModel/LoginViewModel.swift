//
//  LoginViewModel.swift
//  CinemaApp (iOS)
//
//  Created by bnkwsr1 on 15.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginViewModel : ObservableObject {
    @Published var login : String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var actionText: String = ""
    @Published var actionSheet: Bool = false
    
    @Published var isLoginScreen: Bool = true
    
    @Published var isLogin : Bool = true
    
    public var token : String? {
        get {
            UserDefaults.standard.string(forKey: "token")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    func login(onExit : @escaping (String) -> Void) {
        var msg : String = ""
        
        if login.isEmpty || password.isEmpty {
            msg = "Присутствуют пустые поля"
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: [String: String] = [
            "email": login,
            "password": password,
          ]
        
        AF.request("http://cinema.areas.su/auth/login", method: .post, parameters: parameters, headers: headers).responseData(completionHandler: { (res) in
            switch (res.result){
            case .success(let data):
                var json : JSON?
                json = try? JSON(data: data)
                
                if json?["token"].stringValue != nil {
                    self.token = json!["token"].stringValue
                } else {
                    msg = "Данные неверны, повторите попытку"
                    break
                }
                
                msg = "Токен: \(self.token ?? "Empty")"
                break
            case .failure:
                msg = "Проблемы при авторизации"
                break
            }
            
            onExit(msg)
        })
        
    }
    
    func register(onExit : @escaping (String) -> Void) {
        var msg : String = ""
        if password != repeatPassword {
            print(password)
            print(repeatPassword)
            msg = "Пароли не совпадают"
        }
        
        
        if login.isEmpty || password.isEmpty || name.isEmpty || surname.isEmpty || repeatPassword.isEmpty {
            msg = "Присутствуют пустые поля"
        }
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: [String: String] = [
            "email": login,
            "password": password,
            "firstName": name,
            "lastName": surname
          ]
        
        AF.request("http://cinema.areas.su/auth/register", method: .post, parameters: parameters, headers: headers).responseData(completionHandler: { (res) in
            switch (res.result){
            case .success(let data):
                msg = String(data: data, encoding: .utf8)!
                break
            case .failure:
                msg = "Проблемы при регистрации"
                break
            }
            
            onExit(msg)
        })
        
    }

}

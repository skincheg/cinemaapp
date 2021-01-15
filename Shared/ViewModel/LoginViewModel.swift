//
//  LoginViewModel.swift
//  CinemaApp (iOS)
//
//  Created by bnkwsr1 on 15.01.2021.
//

import Foundation

class LoginViewModel : ObservableObject {
    @Published var login : String = ""
    @Published var password: String = ""
    @Published var repeatPassword: String = ""
    
    @Published var isLogin : Bool = true
    
    func login(login: String, password: String) -> String {
        return "Login success"
    }
    
    func register(login: String, password: String) -> String {
        return "Register success"
    }
}

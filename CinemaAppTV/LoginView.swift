//
//  LoginView.swift
//  CinemaApp (iOS)
//
//  Created by bnkwsr1 on 15.01.2021.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginData : LoginViewModel
    @EnvironmentObject var appData : AppViewModel
    @EnvironmentObject var mainData : MainViewModel
    
    var body: some View {
        ZStack {
            VStack{
                Spacer()
                VStack {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 100))
                        .foregroundColor(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                    Text("WorldCinema")
                        .foregroundColor(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                }
                Spacer()
            
                
                if !loginData.isLogin {
                    VStack {
                        ZStack(alignment: .leading) {
                            if loginData.name.isEmpty {
                                Text("Имя")
                                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                    .padding()
                            }
                            TextField("Имя", text: $loginData.name)
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),lineWidth: 1)
                                )
                        }
                        ZStack(alignment: .leading) {
                            if loginData.surname.isEmpty {
                                Text("Фамилия")
                                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                    .padding()
                            }
                            TextField("Фамилия", text: $loginData.surname)
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),lineWidth: 1)
                                )
                        }
                    }
                        .padding(.horizontal, 50)
                }
                
                VStack {
                    ZStack(alignment: .leading) {
                        if loginData.login.isEmpty {
                            Text("E-mail")
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding()
                        }
                        TextField("E-mail", text: $loginData.login)
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8.0)
                                    .stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),lineWidth: 1)
                            )
                    }
                    ZStack(alignment: .leading) {
                        if loginData.password.isEmpty {
                            Text("Пароль")
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding()
                        }
                        SecureField("Пароль", text: $loginData.password)
                            .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8.0)
                                    .stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),lineWidth: 1)
                            )
                    }
                }
                    .padding(.horizontal, 50)
                
                if !loginData.isLogin {
                    VStack {
                        ZStack(alignment: .leading) {
                            if loginData.repeatPassword.isEmpty {
                                Text("Повторите пароль")
                                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                    .padding()
                            }
                            SecureField("Повторите пароль", text: $loginData.repeatPassword)
                                .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8.0)
                                        .stroke(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),lineWidth: 1)
                                )
                        }
                    }
                        .padding(.horizontal, 50)
                }
                Spacer()
                VStack {
                    Button(action: {
                        withAnimation() {
                            if loginData.isLogin {
                                print(loginData.login(onExit: { (str) in
                                    loginData.actionText = str
                                    loginData.actionSheet.toggle()

                                    appData.checkUser { (isLogged) in
                                        if isLogged {
                                            mainData.loadCover { (_) in
                                                appData.isLogged = true
                                            }
                                        } else {
                                            appData.isLogged = false
                                        }
                                    }
                                }))
                            } else {
                                print(loginData.register(onExit: { (str) in
                                    loginData.actionText = str
                                    loginData.actionSheet.toggle()
                                    loginData.isLoginScreen.toggle()
                                }))
                            }
                        }
                    }, label: {
                        Text(loginData.isLogin ? "Войти" : "Зарегистрироваться")
                            .fontWeight(.bold)
                    })
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                        .cornerRadius(8)
                        .padding(.horizontal, 50)
                        .foregroundColor(.white)
                    .buttonStyle(CardButtonStyle())
                    
                    Button(action: {
                        withAnimation(.easeOut) {
                            loginData.isLogin.toggle()
                        }
                    }, label: {
                        Text(loginData.isLogin ? "Регистрация" : "У меня уже есть аккаунт")
                            .fontWeight(.bold)
                    })
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                        .cornerRadius(8)
                        .padding(.horizontal, 50)
                        .foregroundColor(.white)
                    .buttonStyle(CardButtonStyle())
                }
                Spacer()
            }
        }
    }
}

//
//  MainView.swift
//  CinemaApp
//
//  Created by bnkwsr1 on 16.01.2021.
//

import SwiftUI
import Kingfisher

struct MainView: View {
    @EnvironmentObject var mainData : MainViewModel
    @EnvironmentObject var appData : AppViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    VStack {
                        ZStack {
                            Image(uiImage: UIImage(data: mainData.coverData[0])!)
                                .resizable()
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08362521976, green: 0.04971850663, blue: 0.04156858474, alpha: 1)).opacity(0),
                                                                       Color(#colorLiteral(red: 0.08362521976, green: 0.04971850663, blue: 0.04156858474, alpha: 1))]), startPoint: .init(x: 0.5, y: 0.5), endPoint: .bottom)
                            Image(uiImage: UIImage(data: mainData.coverData[1])!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width / 2, height: 100, alignment: .center)
                        }
                        
                        Button(action: {
                            print(123)
                        }, label: {          
                            Text("Смотреть")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                                .cornerRadius(8)
                                .padding(.horizontal, 100)
                                .foregroundColor(.white)
                        })
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 2)
                VStack {
                    HStack {
                        Text("В тренде")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                            .padding(.leading, 20)
                            .padding(.top, 30)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 20) {
                            ForEach(mainData.trendMovies) { movie in
                                if let url = URL(string: "http://cinema.areas.su/up/images/\(movie.poster)") {
                                    KFImage(url)
                                        .resizable()
                                        .cacheMemoryOnly()
                                        .frame(width: 100, height: 150)
                                        .onTapGesture {
                                            withAnimation {
                                                appData.currentMovie = movie
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.leading, 20)
                    }
                    .onAppear {
                        mainData.getMovies(filter: .inTrend) { (result) in
                            print(result)
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text("Новое")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                            .padding(.leading, 20)
                            .padding(.top, 30)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(mainData.newMovies) { movie in
                                if let url = URL(string: "http://cinema.areas.su/up/images/\(movie.poster)") {
                                    KFImage(url)
                                        .resizable()
                                        .cacheMemoryOnly()
                                        .frame(width: 250, height: 150)
                                        .onTapGesture {
                                            withAnimation {
                                                appData.currentMovie = movie
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.leading, 20)
                    }
                    .onAppear {
                        mainData.getMovies(filter: .new) { (result) in
                            print(result)
                        }
                    }
                }
                
                VStack {
                    HStack {
                        Text("Для вас")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1)))
                            .padding(.leading, 20)
                            .padding(.top, 30)
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(mainData.forMeMovies) { movie in
                                if let url = URL(string: "http://cinema.areas.su/up/images/\(movie.poster)") {
                                    KFImage(url)
                                        .resizable()
                                        .cacheMemoryOnly()
                                        .frame(width: 100, height: 150)
                                        .onTapGesture {
                                            withAnimation {
                                                appData.currentMovie = movie
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.leading, 20)
                    }
                    .onAppear {
                        mainData.getMovies(filter: .forMe) { (result) in
                            print(result)
                        }
                    }
                }
                Spacer(minLength: 100)
            }
        }
    }
}

struct MainViewPreview: PreviewProvider {
    static var previews: some View {
        //        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        MainView()
            .environmentObject(MainViewModel())
    }
}

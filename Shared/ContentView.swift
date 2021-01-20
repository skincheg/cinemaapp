//
//  ContentView.swift
//  Shared
//
//  Created by bnkwsr1 on 15.01.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>

    @State var isLoadedApp = false

    @State var activeTab = "home"
    
    @StateObject var loginData = LoginViewModel()
    @StateObject var mainData = MainViewModel()
    @StateObject var appData = AppViewModel()
    @StateObject var movieAboutData = MovieAboutViewModel()
    
    var body: some View {
        ZStack() {
            Color(#colorLiteral(red: 0.08362521976, green: 0.04971850663, blue: 0.04156858474, alpha: 1))
                .ignoresSafeArea(.all)
            
            if isLoadedApp {
                if !appData.isLogged {
                    LoginView()
                        .environmentObject(loginData)
                        .environmentObject(appData)
                        .environmentObject(mainData)
                        .actionSheet(isPresented: $loginData.actionSheet) {
                            ActionSheet(title: Text(loginData.actionText))
                        }
                } else {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                        MainView()
                            .environmentObject(mainData)
                            .environmentObject(appData)

                        HStack(spacing: 75) {
                            
                            Button {
                                activeTab = "home"
                            } label: {
                                Image(systemName: "house")
                                    .foregroundColor(activeTab == "home" ? Color.red : Color(#colorLiteral(red: 0.458770752, green: 0.45885396, blue: 0.4587654471, alpha: 1)))
                            }

                            Button {
                                activeTab = "square.and.pencil"
                            } label: {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(activeTab == "square.and.pencil" ? Color.red : Color(#colorLiteral(red: 0.458770752, green: 0.45885396, blue: 0.4587654471, alpha: 1)))
                            }

                            Button {
                                activeTab = "heart.fill"
                            } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(activeTab == "heart.fill" ? Color.red : Color(#colorLiteral(red: 0.458770752, green: 0.45885396, blue: 0.4587654471, alpha: 1)))
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .padding(.bottom, 20)
                        .background(Color(#colorLiteral(red: 0.1114914641, green: 0.101682432, blue: 0.09745747596, alpha: 1)))
                    }
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(#colorLiteral(red: 0.919036448, green: 0.3298438191, blue: 0.06171738356, alpha: 1))))
            }
            
            if appData.currentMovie != nil {
                MovieAbout()
                    .environmentObject(appData)
                    .environmentObject(movieAboutData)
            }
            
        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            appData.isLogged = false
            
            appData.checkUser { (isLogged) in
                if isLogged {
                    mainData.loadCover { (_) in
                        isLoadedApp = true
                    }
                } else {
                    isLoadedApp = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        ContentView()
    }
}

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

    @StateObject var loginData = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.07116285712, green: 0.04213490337, blue: 0.02960851043, alpha: 1))
                .ignoresSafeArea(.all)
            LoginView()
                .environmentObject(loginData)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        ContentView()
    }
}

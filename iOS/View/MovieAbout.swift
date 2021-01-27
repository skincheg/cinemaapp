//
//  MovieAbout.swift
//  CinemaApp
//
//  Created by bnkwsr1 on 16.01.2021.
//

import SwiftUI
import Kingfisher
import AVKit

struct MovieAbout: View {
    @EnvironmentObject var appData : AppViewModel
    
    @EnvironmentObject var movieAbout : MovieAboutViewModel
    
    @State var colorAge = Color.white
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.08362521976, green: 0.04971850663, blue: 0.04156858474, alpha: 1))
                .ignoresSafeArea(.all)
            
            ScrollView {
                VStack {
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                            if let url = URL(string: "http://cinema.areas.su/up/images/\(appData.currentMovie?.poster ?? "")") {
                                KFImage(url)
                                    .resizable()
                                    .onAppear {
                                    }
                            }
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.08362521976, green: 0.04971850663, blue: 0.04156858474, alpha: 1)).opacity(0),
                                                                       Color(#colorLiteral(red: 0.08362521976, green: 0.04971850663, blue: 0.04156858474, alpha: 1))]), startPoint: .init(x: 0.5, y: 0.5), endPoint: .bottom)
                            
                            Button(action: {
                                withAnimation {
                                    appData.videoUrl = URL(string: "http://cinema.areas.su/up/video/videoplayback (1).mp4".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
                                    
                                    print(appData.videoUrl)
                                    movieAbout.isShowingVideo.toggle()
                                }
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
                            .padding(.bottom, 50)
                            
                            Button {
                                withAnimation {
                                    appData.currentMovie = nil
                                }
                            } label: {
                                Image(systemName: "arrow.left")
                                    .foregroundColor(Color.white)
                            
                            }
                            .frame(width: 50, height: 50)
                            .position(x: 30, y: 50)

                        }
                    }
                    .frame(height: UIScreen.main.bounds.height / 2)
                    
                    HStack {
                        if movieAbout.episodes?.count != 0 {
                            Text("\(movieAbout.episodes?.count ?? 0) сезонов")
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                        
                        Text("\(appData.currentMovie?.age ?? "")+")
                            .foregroundColor(colorAge)
                    }
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(appData.currentMovie?.tags ?? []) { tag in
                                Text("\(tag.tagName)")
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .foregroundColor(.white)
                                    .background(Color(#colorLiteral(red: 1, green: 0.0915075615, blue: 0, alpha: 1)))
                                    .cornerRadius(4)
                            }
                        }
                    }
                    .padding(.leading)
                    
                    VStack(alignment: .leading) {
                        Text("Описание")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.leading, 20)
                            .padding(.bottom)
                        Text("\(appData.currentMovie?.description ?? "")")
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.bottom)
                            .font(.system(size: 14))
                    }
                    
                    if !(appData.currentMovie?.images ?? []).isEmpty {
                        VStack(alignment: .leading) {
                            Text("Кадры")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                                .padding(.bottom)
                            
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 20) {
                                    ForEach(appData.currentMovie?.images ?? [], id: \.self) { img in
                                        if let url = URL(string: "http://cinema.areas.su/up/images/\(img)") {
                                            KFImage(url)
                                                .resizable()
                                                .cacheMemoryOnly()
                                                .frame(width: 250, height: 150)
                                        }
                                    }
                                }
                                .padding(.leading, 20)
                            }
                        }
                    }
                    
                    if !(movieAbout.episodes ?? []).isEmpty {
                        VStack(alignment: .leading) {
                            Text("Эпизоды")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                                .padding(.bottom)
                            ForEach(movieAbout.episodes ?? []) { episode in
                                HStack {
                                    if let url = URL(string: "http://cinema.areas.su/up/images/\(appData.currentMovie?.poster ?? "")") {
                                        KFImage(url)
                                            .resizable()
                                            .frame(width: 150, height: 100)
                                    }
                                    VStack(alignment: .leading) {
                                        Text("\(episode.name)")
                                            .font(.system(size: 14, weight: .bold))
                                        
                                        Spacer()
                                        
                                        Text("\(String(episode.description.prefix(70)))...")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(#colorLiteral(red: 0.6861984134, green: 0.6863184571, blue: 0.6861909032, alpha: 1)))
                                        
                                        Spacer()
                                        
                                        Text("\(episode.year)")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color(#colorLiteral(red: 0.6861984134, green: 0.6863184571, blue: 0.6861909032, alpha: 1)))
                                    }
                                    Spacer()
                                }
                                .foregroundColor(.white)
                                .padding(.leading, 20)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }

        }
        .ignoresSafeArea(.all, edges: .all)
        .onAppear {
            movieAbout.getMovie(movieId: appData.currentMovie?.movieId ?? "") { (res) in
                print(res)
            }
            
            print(appData.currentMovie!.age)
            switch(appData.currentMovie?.age) {
            case "18":
                self.colorAge = Color(#colorLiteral(red: 1, green: 0.0915075615, blue: 0, alpha: 1))
                break
            case "16":
                self.colorAge = Color(#colorLiteral(red: 0.9490196078, green: 0.431372549, blue: 0.2705882353, alpha: 1))
                break
            case "12":
                self.colorAge = Color(#colorLiteral(red: 1, green: 0.6477315426, blue: 0.5530529022, alpha: 1))
                break
            case "6":
                self.colorAge = Color(#colorLiteral(red: 0.9803921569, green: 0.8352941176, blue: 0.7882352941, alpha: 1))
                break
            default:
                break
            }
        }
    }
}


//struct VideoPlayer : UIViewControllerRepresentable {
//    var videoURL : String
//
//    func makeUIViewController(context: Context) -> AVPlayerViewController {
//        let controller = AVPlayerViewController()
//        let url = URL(string: "https://i.imgur.com/BemjriO.mp4")!
//        let player = AVPlayer(url: url)
//        controller.player = player
//
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
//
//    }
//}

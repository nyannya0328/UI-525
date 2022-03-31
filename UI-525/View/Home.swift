//
//  Home.swift
//  UI-525
//
//  Created by nyannyan0328 on 2022/03/31.
//

import SwiftUI

struct Home: View {
    @State var currentIndex : Int = 0
    @State var currentTitle : String = "Films"
    @Environment(\.colorScheme) var scheme
    @Namespace var animation
    
    @State var detailMovie : Movie?
    @State var showDetail : Bool = false
    @State var currentCardSize : CGSize = .zero
    
    var body: some View {
        ZStack{
            BGBar()
            
            VStack{
                
                NavBar()
                
                SnapCarousel(spacing: 20, trailingSpace: 100, index: $currentIndex, items: movies) { movie in
                    
                    
                    GeometryReader{proxy in
                        let size = proxy.size
                        
                        Image(movie.artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .matchedGeometryEffect(id: movie.id, in: animation)
                            .cornerRadius(10)
                            .onTapGesture {
                                
                                currentCardSize = size
                                detailMovie = movie
                                
                                withAnimation{
                                    
                                    
                                    showDetail = true
                                }
                                
                                
                            }
                        
                    }
                    
                }
                .padding(.top,70)
                
                CustomIndicartor()
                
                
                
                HStack{
                    
                    Text("Popular")
                        .font(.title.bold())
                        
                    Spacer()
                    
                    Button("See More"){
                        
                        
                    }
                    
                }
                .padding()
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing:20){
                        
                        
                        ForEach(movies){move in
                            
                            Image(move.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 130)
                                .cornerRadius(10)
                                .padding(9)
                                .background(
                                
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                      
                                        .stroke(.red,lineWidth: 2)
                                      
                                
                                )
                                .shadow(color: .black.opacity(0.3), radius: 5, x: 5, y: 5)
                                .shadow(color: .black.opacity(0.3), radius: 3, x: -3, y: -3)
                            
                            
                        }
                    }
                }
                .padding([.horizontal,.top])
                
                
            }
            .overlay {
                
                if let movie = detailMovie,showDetail{
                    
                    
                    DetailView(movie:movie, animation: animation, currentCardSize: $currentCardSize, showDetail: $showDetail, detailMovie: $detailMovie)
                    
                    
                }
            }
            
          
            
            
            
           
            
        }
    }
    
    @ViewBuilder
    func CustomIndicartor()->some View{
        
        HStack(spacing:10){
            
            
            ForEach(movies.indices,id:\.self){movie in
                
                Capsule()
                    .fill(currentIndex == movie ? .blue : .white)
                    .frame(width: currentIndex == movie ? 15 : 5, height: currentIndex == movie ? 15 : 5)
                
            }
        }
    }
    
    @ViewBuilder
    func NavBar()->some View{
        
        
        HStack{
            
            ForEach(["Films","Locarity"],id:\.self){tab in
                
                Button {
                    
                    currentTitle = tab
                } label: {
                    
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background{
                          
                                
                                    if currentTitle == tab{
                                        
                                        Capsule()
                                            .fill(.regularMaterial)
                                            .environment(\.colorScheme, .dark)
                                            .matchedGeometryEffect(id: "TAB", in: animation)
                                        
                                    }
                            
                        
                        }
                }

                
            }
            
            
        }
        
    }
    @ViewBuilder
    func BGBar()->some View{
        
        
        GeometryReader{proxy in
            
            let size = proxy.size
            
            TabView(selection: $currentIndex) {
                
                ForEach(movies.indices,id:\.self){index in
                    
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                     
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: currentIndex)
            
            let color : Color = (scheme == .dark ? .black : .white)
            
            
            LinearGradient(colors: [
            
            
            
                .black,
                .clear,
                color.opacity(0.15),
                color.opacity(0.7),
                color.opacity(0.8),
                color.opacity(0.8),
                
            
            
            
            
            ], startPoint: .top, endPoint: .bottom)
            
            Rectangle()
                .fill(.ultraThinMaterial)
            
            
        }
        .ignoresSafeArea()
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

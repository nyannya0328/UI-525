//
//  DetailView.swift
//  UI-525
//
//  Created by nyannyan0328 on 2022/03/31.
//

import SwiftUI

struct DetailView: View {
    var movie : Movie
    var animation : Namespace.ID
    @Binding var currentCardSize : CGSize
    @Binding var showDetail : Bool
    @Binding var detailMovie : Movie?
    
    @State var showDetailContent : Bool = false
    
    @State var offset : CGFloat = 0
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            
            VStack{
                
                Image(movie.artwork)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: currentCardSize.width, height: currentCardSize.height)
                    .cornerRadius(10)
                    .matchedGeometryEffect(id: movie.id, in: animation)
                
                VStack(spacing:15){
                    
                    Text("Stroy Plot")
                        .font(.title.weight(.ultraLight))
                        .frame(maxWidth:.infinity,alignment: .leading)
                    
                    Text(sampleText)
                        .multilineTextAlignment(.leading)
                    
                    
                    
                    Button {
                        
                    } label: {
                        
                        Text("Book Ticket")
                            .font(.title.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.vertical,20)
                            .padding(.horizontal)
                            .frame(maxWidth:.infinity)
                            .background(.blue,in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                    }
                    .padding()

                    
                }
                .opacity(showDetailContent ? 1 : 0)
                .offset(y: showDetailContent ? 0 : 250)
                .padding(.leading,13)
            }
            .modifier(OffsetModifier(offset: $offset))
            
            
        }
        .coordinateSpace(name: "SCROLL")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
        
            Rectangle().fill(.ultraThinMaterial).ignoresSafeArea()
        
        )
        .onAppear {
            withAnimation{
                
                showDetailContent = true
            }
        }
        .onChange(of: offset) { newValue in
            
            if newValue > 120{
                
                withAnimation(.easeInOut){
                    
                    showDetailContent = false
                }
                
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.easeInOut){
                
                
                                    showDetail = false
                                }
                            }
            }

        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

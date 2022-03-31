//
//  OffsetModifier.swift
//  UI-525
//
//  Created by nyannyan0328 on 2022/03/31.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    
    @Binding var offset : CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                
                GeometryReader{proxy in
                    
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                     
                }
                .onPreferenceChange(OffsetKey.self) { minY in
                    
                    
                    self.offset = minY
                }
                
            }
    }
}
struct OffsetKey : PreferenceKey{
    
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        
        value = nextValue()
    }
}

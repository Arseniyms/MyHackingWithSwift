//
//  ContentView.swift
//  Drawing
//
//  Created by Arseniy Matus on 30.03.2022.
//

import SwiftUI

struct Arrow: Shape {
    
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(CGRect(x: rect.midX, y: rect.maxY, width: rect.width * 0.1, height: -rect.height * 0.8))
        path.addRect(CGRect(x: rect.midX, y: rect.maxY, width: -rect.width * 0.1, height: -rect.height * 0.8))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.height * 0.2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.height * 0.2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        

        
        return path
    }
}

struct ContentView: View {
    var body: some View {
        Arrow()
//            .stroke()
            .fill(.red)
            .frame(width: 50, height: 300)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

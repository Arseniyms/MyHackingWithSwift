//
//  SkiDetailView.swift
//  SnowSeeker
//
//  Created by Arseniy Matus on 10.05.2022.
//

import SwiftUI

struct SkiDetailView: View {
    var resort: Resort
    
    var body: some View {
        Group {
            VStack {
                Text("Elevation")
                    .font(.caption.bold())
                Text("\(resort.elevation)m")
                    .font(.title3)
            }
            VStack {
                Text("Snow")
                    .font(.caption.bold())
                Text("\(resort.snowDepth)cm")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)

    }
}

struct SkiDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailView(resort: Resort.example)
    }
}

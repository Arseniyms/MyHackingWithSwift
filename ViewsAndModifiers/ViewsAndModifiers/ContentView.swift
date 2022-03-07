//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Arseniy Matus on 26.02.2022.
//

import SwiftUI
import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {

    @State private var results = [Result]()
    @State private var count = 1
    
    func getData(_ number: Int) async {
        let urlStr = "https://itunes.apple.com/search?term=taylor+swift&entity=song&limit=\(count)"
        
        guard let url = URL(string: urlStr) else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
    

    
    @ViewBuilder var getSong: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await getData(count)
        }
        
    }
    
    
    var body: some View {
        VStack{
            getSong
            
            Spacer()
            HStack{
                Button("Back"){
                    count -= 1
                }
                .padding()
                Spacer()
                Button("Next"){
                    count += 1
                }
                .padding()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

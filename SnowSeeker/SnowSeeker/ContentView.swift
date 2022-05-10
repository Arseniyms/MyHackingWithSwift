//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Arseniy Matus on 10.05.2022.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var isAlphabeticalOrder = true
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.black, lineWidth: 1)
                            )

                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                                .accessibilityLabel("This is favorite resort")
                        }
                    }
                }
            }
            .navigationTitle("SnowSeeker")
            .toolbar {
                Button {
                    isAlphabeticalOrder.toggle()
                } label: {
                    Image(systemName: "arrow.up.arrow.down")
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            
            WelcomeView()

        }
        .environmentObject(favorites)
    }

    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        }
        return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var sortedResorts: [Resort] {
        if isAlphabeticalOrder {
            return filteredResorts.sorted(by: <)
        } else {
            return filteredResorts.sorted(by: >)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

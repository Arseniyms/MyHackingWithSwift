//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Arseniy Matus on 10.05.2022.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    @State private var isShowingFacility = false
    var resort: Resort

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    Text(resort.imageCredit)
                        .font(.caption)
                        .padding(3)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .opacity(0.4)
                        )
                }
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailView(resort: resort)}
                        VStack(spacing: 10) { SkiDetailView(resort: resort)}
                    } else {
                        ResortDetailView(resort: resort)
                        SkiDetailView(resort: resort)
                    }
                    
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilityTypes) {facility in
                            Button {
                                selectedFacility = facility
                                isShowingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    
                    Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
                        if favorites.contains(resort) {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.vertical)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(resort.name)
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $isShowingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description)
        }
    }
}

//struct ResortView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ResortView(resort: Resort.example)
//        }
//    }
//}

//
//  ContentView.swift
//  MapBucketList
//
//  Created by Arseniy Matus on 20.04.2022.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion,showsUserLocation: true, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                                
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedLocation = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.4)
                    .frame(width: 32, height: 32)
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button() {
                            viewModel.addLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .foregroundColor(.white)
                                .font(.title)
                                .background(.black.opacity(0.75))
                                .clipShape(Circle())
                                .padding(.trailing)
                        }
                    }
                }
                
            }
            .sheet(item: $viewModel.selectedLocation) { place in
                EditView(location: place) { newLocation in
                    viewModel.update(newLocation: newLocation)
                }
            }
        } else {
            Button("Unlock places") {
                viewModel.authenticate()
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

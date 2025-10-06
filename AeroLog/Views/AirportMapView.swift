//
//  AirportMapView.swift
//  AeroLog
//
//  Created by Yu-Han on 7/10/2025.
//

import SwiftUI
import MapKit

struct AirportMapView: View {
    let departure: String
    let arrival: String

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093), // default: Sydney
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )

    @State private var annotations: [CityAnnotation] = []

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { pin in
            MapMarker(coordinate: pin.coordinate, tint: pin.isDeparture ? .blue : .red)
        }
        .onAppear {
            loadAirportPins()
        }
        .navigationTitle("Route Map")
    }

    // MARK: - Load Geocoded Annotations
    private func loadAirportPins() {
        let geocoder = CLGeocoder()
        let cities = [(departure, true), (arrival, false)] // (name, isDeparture)

        annotations.removeAll()

        for (city, isDeparture) in cities {
            geocoder.geocodeAddressString(city) { placemarks, error in
                if let location = placemarks?.first?.location {
                    let pin = CityAnnotation(
                        id: UUID(),
                        coordinate: location.coordinate,
                        title: city,
                        isDeparture: isDeparture
                    )
                    DispatchQueue.main.async {
                        annotations.append(pin)
                        if isDeparture {
                            region.center = location.coordinate
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Custom Identifiable Annotation
struct CityAnnotation: Identifiable {
    let id: UUID
    let coordinate: CLLocationCoordinate2D
    let title: String
    let isDeparture: Bool
}

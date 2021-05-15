//
//  PlacesViews.swift
//  Place_ME (map_kit_test)
//
//  Created by Дмитрий Игнатьев on 15.05.2021.
//

import Foundation
import MapKit

class PlacesMarkersView: MKMarkerAnnotationView{
    override var annotation: MKAnnotation?{
        willSet{
            guard let places = newValue as? Places else {
                return
            }
            
            canShowCallout = true   // shows our callout on the map
            calloutOffset = CGPoint (x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)  //callout value
            
            markerTintColor = places.markerTintColor
            if let letter = places.discipline?.first{
                glyphText = String(letter)   //the letter on the location marker
            }
        }
    }
}

//
//  Places.swift
//  Place_ME (map_kit_test)
//
//  Created by Дмитрий Игнатьев on 13.05.2021.
//

import Foundation
import MapKit
import Contacts  //determining the exact location on the map

class Places: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let coordinate: CLLocationCoordinate2D
    
   init (
    title: String?,
    locationName: String?,
    discipline: String?,
    coordinate: CLLocationCoordinate2D
    ) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }

    init?(feature: MKGeoJSONFeature){
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
        else{
            return nil
        }
        
        title = properties["title"] as? String
        locationName = properties["locationName"] as? String
        discipline = properties["discipline"] as? String
        coordinate = point.coordinate
        
        super.init()
    }
    
    var subtitle: String?{
        return locationName
    }

    var mapItem: MKMapItem? {
    guard let location = locationName else {
    return nil
    }
        let adressDict = [CNPostalAddressStateKey: location] //getting our point on the map
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: adressDict)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    var markerTintColor: UIColor {
        switch discipline {
        case "Walking route": return .purple
        case "Cathedral": return .blue
        case "Monument": return .yellow
       
        default:
            return .green
        }
    }
    
}


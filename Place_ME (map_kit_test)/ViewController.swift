//
//  ViewController.swift
//  Place_ME (map_kit_test)
//
//  Created by Дмитрий Игнатьев on 13.05.2021.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 50.44761935392397 , longitude: 30.522026437923916)
        mapView.centerLocation(initialLocation)
        
        let cameraCenter = CLLocation(latitude: 50.44761935392397, longitude: 30.522026437923916)
        let region = MKCoordinateRegion (center: cameraCenter.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000) //100*100 kms view borders
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRage = MKMapView.CameraZoomRange (maxCenterCoordinateDistance: 160000) //120 km max zoom range (It will be just Kyiv map)
        mapView.setCameraZoomRange(zoomRage, animated: true)
        
    }
    
    
}
extension MKMapView{
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000){
        let coordinateRegion = MKCoordinateRegion (center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)  //smooth loading animation
    }
}
//we assign our view controller as a delegate of the map view class
extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard let annotation = annotation as? Places
        else {
            return nil   // checking the annotation if it refers to the json Places array
        }
        
        let identifier = "places"  //identifier for annotation view
        let view: MKMarkerAnnotationView //for correct display we refer to MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: "places") as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint (x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTaped control: UIControl){
        guard let places = view.annotation as? Places else {
            return
        }
    
    
    let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
    
    places.mapItem?.openInMaps(launchOptions: launchOptions)
    
    }
}

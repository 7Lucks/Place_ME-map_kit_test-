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
    }


}
extension MKMapView{
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000){
        let coordinateRegion = MKCoordinateRegion (center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)  //smooth loading animation
    }
}

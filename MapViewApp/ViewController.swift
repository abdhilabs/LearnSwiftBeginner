//
//  ViewController.swift
//  MapViewApp
//
//  Created by Abdhi on 21/04/20.
//  Copyright © 2020 Abdhilabs. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //1
        mapView.mapType = .standard
        //2
        let location = CLLocationCoordinate2D(latitude: -7.370380, longitude: 110.314290)
        //3
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        //4
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Magelang"
        annotation.subtitle = "Grabag"
        mapView.addAnnotation(annotation)
        
    }


}


//
//  MapViewController.swift
//  Dealicious
//
//  Created by Vanessa Lange on 10/27/22.
//  Copyright © 2022 Mina Sedhom. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Parse

protocol HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark)
}

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    var selectedPin:MKPlacemark? = nil
    var deals = [PFObject]()
    var selectedDeal: PFObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 100
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        getDeal()
        let locationSearchTable = storyboard!.instantiateViewController(
            withIdentifier: "searchTable") as! ShopsListTableViewController
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        
    }
    
   
    func getDeal(){
        let query = PFQuery(className: "Deals")
        query.includeKeys(["store", "latitude", "longitude", "product"])
        query.findObjectsInBackground{ [self](deals, error) in
            if deals != nil {
                let returnedDeals = deals!
                    for i in returnedDeals {
                        if i["latitude"] != nil {
                            let annotation = MKPointAnnotation();
                            annotation.coordinate = CLLocationCoordinate2D(latitude: i["latitude"] as! Double, longitude: i["longitude"] as! Double);
                            annotation.title = i["product"] as? String;
                            annotation.subtitle = i["store"] as? String;
                            self.mapView.addAnnotation(annotation)
                        }
                    }
                
                }
            }
           
        
        }
    
}

extension MapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025))
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
}


extension MapViewController: HandleMapSearch {
    func dropPinZoomIn(placemark:MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        //mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = city
        }
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
}



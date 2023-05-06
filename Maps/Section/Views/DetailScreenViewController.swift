//
//  DetailScreenViewController.swift
//  Maps
//
//  Created by Rabbia Ijaz on 28/04/2023.
//

import Foundation
import MapKit
import SwiftUI

class DetailScreenViewController:UIViewController {
    
    //MARK: - UI Components
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    //MARK: Properties
    var id = ""
    var detailScreenViewModel = DetailScreenViewModel()
    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = UIColor(named: "red")
    }
    
    class func getInstance(id: String) -> DetailScreenViewController {
        let vc = DetailScreenViewController()
        vc.id = id
        vc.fetchCityDetail(id: vc.id)
        return vc
    }
    
    private func setupUI() {
        setupMapView()
        setupDetailBottomBheet()
    }
    
    private func setupDetailBottomBheet() {
        let bottomSheetView = BottomSheetView(maximumHeight: 330, minimumHeight: 143 ,detailScreenViewModel: detailScreenViewModel)
        let screenHeight = UIScreen.main.bounds.height
        let bottomSheetHeight = 143
        bottomSheetView.frame = CGRect(x: 0, y: Int(screenHeight) - bottomSheetHeight, width: Int(UIScreen.main.bounds.width), height: bottomSheetHeight)
        bottomSheetView.detailScreenViewModel = detailScreenViewModel
        self.view.addSubview(bottomSheetView)
        self.view.layoutIfNeeded()
        
        NSLayoutConstraint.activate([
            bottomSheetView.topAnchor.constraint(equalTo: mapView.bottomAnchor),
            bottomSheetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    private func setupMapView() {
        
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        mapView.delegate = self
        showPin()
    }
    
    func showPin() {
        DispatchQueue.main.async {
            let annotation = self.detailScreenViewModel.getAnnotation()
            let coordinate = annotation.coordinate
            self.mapView.centerCoordinate = coordinate
            self.mapView.setCenter(coordinate, animated: true)
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
            self.mapView.showAnnotations(self.mapView.annotations, animated: false)
        }
    }
    
    func fetchCityDetail(id:String) {
        detailScreenViewModel.fetchCityDetail(id: id) {
            [weak self] in
            DispatchQueue.main.async {
                self?.setupUI()
            }
        }
    }
}

//MARK: - MKMapViewDelegate
extension DetailScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else { return nil }
        let identifier = "CustomAnnotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}

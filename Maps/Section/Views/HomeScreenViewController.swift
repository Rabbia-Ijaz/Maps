//
//  HomeScreenViewController.swift
//  Maps
//
//  Created by Rabbia Ijaz on 26/04/2023.
//

import UIKit
import MapKit
import CoreLocation

class HomeScreenViewController: UIViewController{
    
    //MARK: - UI Components
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let shadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 25
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 10
        return view
    }()
    
    let searchTextField: UITextField = {
        //Search icon
        let searchIconView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let searchIconImageView = UIImageView(frame: CGRect(x: 15, y: 15, width: 20, height: 20))
        searchIconImageView.image = UIImage(systemName: "magnifyingglass")
        searchIconImageView.tintColor = UIColor(named: "red")
        searchIconView.addSubview(searchIconImageView)
        
        //Clear icon
        let clearButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        let clearButton = UIButton(frame: CGRect(x: 15, y: 15, width: 20, height: 20))
        clearButton.setTitle("", for: .normal)
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = UIColor(named: "red")
        clearButton.addTarget(self, action: #selector(refresh(_:)), for: .touchUpInside)
        clearButtonView.addSubview(clearButton)
        
        let textField = UITextField()
        textField.placeholder = "Search"
        textField.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = textField.heightAnchor.constraint(equalToConstant: 50)
        heightConstraint.isActive = true
        
        textField.tintColor = .gray
        textField.borderStyle = .roundedRect
        textField.layer.borderWidth = 1
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 25
        textField.clearButtonMode = .never
        
        textField.leftView = searchIconView
        textField.leftViewMode = .always
        textField.rightView = clearButtonView
        textField.rightViewMode = .whileEditing
        textField.clipsToBounds = true
        return textField
    }()
    
    //MARK: Properties
    let homeScreenViewModel = HomeScreenViewModel()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
}


//MARK: - UI Setup functions
extension HomeScreenViewController {
    private func setupUI() {
        setupMapView()
        setupSearchView()
    }
    
    private func setupSearchView() {
        view.addSubview(shadowView)
        view.addSubview(searchTextField)
        
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            shadowView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        searchTextField.delegate = self
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
        ])
    }
    
    private func setupMapView() {
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

//MARK: - Helper functions
extension HomeScreenViewController {
    func showPins() {
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations) // removing old annotations
            self.mapView.addAnnotations(self.homeScreenViewModel.getAnnotations())
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            if self.homeScreenViewModel.isCityListEmpty() {
                
                self.showToast(message: "No data found")
            }
        }
    }
    
    func fetchCities(searchText:String) {
        homeScreenViewModel.fetchCities(text: searchText) {
            [weak self] in
            self?.showPins()
        }
    }
}

//MARK: - IBAction functions
extension HomeScreenViewController {
    func searchButtonTapped() {
        searchTextField.resignFirstResponder()
        fetchCities(searchText: homeScreenViewModel.searchedText(text: searchTextField.text))
    }
    
    @IBAction func refresh(_ sender: Any) {
        searchTextField.text = ""
        searchTextField.rightViewMode = .never
    }
}

//MARK: - MKMapViewDelegate
extension HomeScreenViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        let identifier = "CustomAnnotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? CustomAnnotationView
        if annotationView == nil {
            annotationView = CustomAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let newViewController = DetailScreenViewController.getInstance(id: homeScreenViewModel.selectedCityId)
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    internal func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let selectedAnnotation = view.annotation as? CustomAnnotation else {
            return
        }
        homeScreenViewModel.setSelectedCityId(id: selectedAnnotation.id ?? "")
    }
}



// MARK: - UITextFieldDelegate
extension HomeScreenViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.rightViewMode = .whileEditing
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        if homeScreenViewModel.isSearchTextFieldEmpty(text: updatedText) {
            textField.rightViewMode = .never
        } else {
            textField.rightViewMode = .whileEditing
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if !homeScreenViewModel.isSearchTextFieldEmpty(text: textField.text ?? "") {
            searchButtonTapped()
        } else {
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.showAnnotations(self.mapView.annotations, animated: false)
        }
        textField.resignFirstResponder()
        return true
    }
}

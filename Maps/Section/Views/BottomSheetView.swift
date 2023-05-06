//
//  BottomSheetView.swift
//  Maps
//
//  Created by Rabbia Ijaz on 29/04/2023.
//

import Foundation
import UIKit

class BottomSheetView: UIView {
    
    let contentView = UIView()
    let cityDetailView = UIView()
    
    var populationSection: DetailSectionView!
    var elevationSection: DetailSectionView!
    var timeZoneSection: DetailSectionView!
    var arrowButton = UIButton(type: .system)
    
    let maximumHeight: CGFloat
    let minimumHeight: CGFloat
    var tapGesture = UITapGestureRecognizer()
    var detailScreenViewModel: DetailScreenViewModel!
    
    init(maximumHeight: CGFloat, minimumHeight: CGFloat, detailScreenViewModel: DetailScreenViewModel) {
        self.maximumHeight = maximumHeight
        self.minimumHeight = minimumHeight
        self.detailScreenViewModel = detailScreenViewModel
        super.init(frame: .zero)
        configureSubview()
        configureTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCityDetailView()
    {
        
        cityDetailView.translatesAutoresizingMaskIntoConstraints = false
        cityDetailView.backgroundColor = .white
        
        cityDetailView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        cityDetailView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        cityDetailView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        cityDetailView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -217).isActive = true
        cityDetailView.heightAnchor.constraint(equalToConstant: 133).isActive = true
        
        
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.setImage(UIImage(named: "chevronUp"), for: .normal)
        arrowButton.tintColor = UIColor(named: "red")
        arrowButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
       
        
        cityDetailView.addSubview(arrowButton)
        arrowButton.topAnchor.constraint(equalTo: cityDetailView.topAnchor, constant: 0).isActive = true
        arrowButton.centerXAnchor.constraint(equalTo: cityDetailView.centerXAnchor, constant: 0).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        arrowButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        let cityIcon = UIImageView()
        cityIcon.translatesAutoresizingMaskIntoConstraints = false
        cityIcon.frame.size = CGSize(width: 68, height: 68)
        cityIcon.image = UIImage(named: "cityIcon")
        
        let cityAndCountryLabel = UILabel()
        cityAndCountryLabel.text = detailScreenViewModel.cityAndCountry
        cityAndCountryLabel.font = UIFont.boldSystemFont(ofSize: 22)
        cityAndCountryLabel.adjustsFontSizeToFitWidth = true
        cityAndCountryLabel.translatesAutoresizingMaskIntoConstraints = false

        let coordinatesLabel = UILabel()
        coordinatesLabel.text = detailScreenViewModel.coordinates
        coordinatesLabel.font = UIFont.systemFont(ofSize: 18)
        coordinatesLabel.adjustsFontSizeToFitWidth = true
        coordinatesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [cityAndCountryLabel,coordinatesLabel])
        cityDetailView.addSubview(cityIcon)
        cityDetailView.addSubview(stackView)
        
        cityIcon.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        cityIcon.leadingAnchor.constraint(equalTo: cityDetailView.leadingAnchor, constant: 0).isActive = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.heightAnchor.constraint(equalToConstant: 73).isActive = true
        stackView.topAnchor.constraint(equalTo: arrowButton.bottomAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: cityIcon.trailingAnchor, constant: 25).isActive = true
        stackView.trailingAnchor.constraint(equalTo: cityDetailView.trailingAnchor).isActive = true
        stackView.alignment = .leading
    }
    
    func setupOtherDetailViews() {
        populationSection = DetailSectionView(title: "Population", value: detailScreenViewModel.population, imageName: "populationIcon")
        elevationSection = DetailSectionView(title: "Elevation", value: detailScreenViewModel.elevation, imageName: "elevationIcon")
        timeZoneSection = DetailSectionView(title: "Timezone", value: detailScreenViewModel.timeZone, imageName: "timeZoneIcon")
        
        let stackView = UIStackView(arrangedSubviews: [populationSection, elevationSection])
        contentView.addSubview(stackView)
        contentView.addSubview(timeZoneSection)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: cityDetailView.bottomAnchor,constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
        ])
        
        timeZoneSection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeZoneSection.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 10),
            timeZoneSection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 30),
            timeZoneSection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -30),
        ])
    }
    
    func configureSubview() {
        contentView.addSubview(cityDetailView)
        setupCityDetailView()
       
        backgroundColor = .white
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 25
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.topAnchor.constraint(equalTo: topAnchor, constant: -25).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.layoutIfNeeded()
    }
    
    func configureTapGesture() {
        tapGesture.addTarget(self, action: #selector(handleTap))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        handleTap()
    }
 
    @IBAction func handleTap() {
        if (UIScreen.main.bounds.height - self.frame.origin.y) == minimumHeight{
            expand()
            arrowButton.setImage(UIImage(named: "chevronDown"), for: .normal)
        } else {
            collapse()
            arrowButton.setImage(UIImage(named: "chevronUp"), for: .normal)
        }
        arrowButton.tintColor = UIColor(named: "red")
        self.layoutIfNeeded()
    }
    
    private func expand() {
        UIView.animate(withDuration: 0.2) {
            self.frame.origin.y = UIScreen.main.bounds.height - self.maximumHeight
            self.frame.size.height = self.maximumHeight
        }
        setupOtherDetailViews()
        
    }
    
    private func collapse() {
        UIView.animate(withDuration: 0.2) {
            self.frame.origin.y = UIScreen.main.bounds.height - self.minimumHeight
            self.frame.size.height = self.minimumHeight
        }
        populationSection.removeFromSuperview()
        elevationSection.removeFromSuperview()
        timeZoneSection.removeFromSuperview()
    }
}


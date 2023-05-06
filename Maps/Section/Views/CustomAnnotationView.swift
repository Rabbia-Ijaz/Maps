//
//  CustomAnnotationView.swift
//  Maps
//
//  Created by Rabbia Ijaz on 28/04/2023.
//

import Foundation
import UIKit
import MapKit

class CustomAnnotationView: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let button = UIButton(type: .detailDisclosure)
        button.setImage(UIImage(systemName: "arrow.forward.circle"), for: .normal)
        button.tintColor = UIColor(named: "red")
        self.rightCalloutAccessoryView = button
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let _ = annotation as? CustomAnnotation else { return }
            self.image = UIImage(named: "pinIcon")
            self.centerOffset = CGPoint(x: 0, y: -self.image!.size.height / 2)
        }
    }
}

class CustomAnnotation: MKPointAnnotation {
    var id: String?
}

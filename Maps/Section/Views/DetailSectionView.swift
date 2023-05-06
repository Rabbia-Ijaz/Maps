//
//  DetailSectionView.swift
//  Maps
//
//  Created by Rabbia Ijaz on 30/04/2023.
//

import Foundation
import UIKit

class DetailSectionView: UIView {
    
    let contentView = UIView()
    let titleLabel = UILabel()
    let valueLabel = UILabel()
    let imageView = UIImageView()
    var imageName = ""
    var title = ""
    var value = ""
    
    init(title:String,value:String,imageName:String) {
        super.init(frame: .zero)
        self.title = title
        self.value = value
        self.imageName = imageName
        setupView()
        configureContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame.size = CGSize(width: 16, height: 16)
        imageView.image = UIImage(named: imageName)
        contentView.addSubview(imageView)
        
        
        
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 16)

        let stackView = UIStackView(arrangedSubviews: [titleLabel,valueLabel])
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        
//        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        imageView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 78).isActive = true
        stackView.alignment = .leading
    }
    
    func configureContentView() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: "lightPink")
        contentView.layer.cornerRadius = 25
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 78).isActive = true
    }
    
}


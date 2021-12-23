//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by macbook on 7.12.2021.
//

import UIKit

class HourlyCollectionViewCell : UICollectionViewCell {
    
    static let identifier = "hourlycollectionviewcell"
    
    private let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "11d.png")
        return imageView
    }()
    
    public let hourLabel : UILabel = {
        let label  = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "20"
        label.textAlignment = .center
        return label
    }()
    
    private let tempLabel : UILabel = {
        let label  = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "16º"
        label.textAlignment = .center
        return label
    }()
    
    private let bottomSepLine : UIView = {
       let view = UIView()
       view.backgroundColor = .white
       return view
    }()
    
    private let topSepLine : UIView = {
       let view = UIView()
       view.backgroundColor = .white
       return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
            
        contentView.backgroundColor = UIColor(red: 116/255, green: 178/255, blue: 240/255, alpha: 1)
        contentView.addSubview(iconImageView)
        contentView.addSubview(hourLabel)
        contentView.addSubview(tempLabel)
  
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2).isActive = true
        hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        hourLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor).isActive = true
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2).isActive = true
        tempLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.75).isActive = true
        tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    
    }
    
    func configure(viewmodel: HourlyCollectionViewCellViewModel){
        iconImageView.image = UIImage(named: viewmodel.imgStr)
        tempLabel.text = viewmodel.temp
        hourLabel.text = viewmodel.hour
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}

//
//  ForeCastTableViewCell.swift
//  WeatherApp
//
//  Created by macbook on 7.12.2021.
//

import UIKit

class ForeCastTableViewCell : UITableViewCell {
    
    static let identifier = "forecasttableviewcell"
    
    private let dayLabel : UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 20)
       label.text = "Wednesday"
       label.textAlignment = .left
       label.textColor = .white
       return label
    }()
    
    private let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "11d.png")
        return imageView
    }()
    
    private let lowLabel : UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 20)
       label.text = "-18º"
       label.textAlignment = .right
       label.textColor = .white
       label.backgroundColor = .clear
       return label
    }()
    
    private let highLabel : UILabel = {
       let label = UILabel()
       label.font = UIFont.systemFont(ofSize: 20)
       label.text = "24º"
       label.textAlignment = .right
       label.textColor = .white
       label.backgroundColor = .clear
       return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(red: 116/255, green: 178/255, blue: 240/255, alpha: 1)
        
        contentView.addSubview(highLabel)
        contentView.addSubview(lowLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(dayLabel)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 13).isActive = true
        dayLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.35).isActive = true
        dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        lowLabel.translatesAutoresizingMaskIntoConstraints = false
        lowLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        lowLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -13).isActive = true
        
        highLabel.translatesAutoresizingMaskIntoConstraints = false
        highLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        highLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        highLabel.trailingAnchor.constraint(equalTo: lowLabel.leadingAnchor, constant: -8).isActive = true
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.95).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: iconImageView.heightAnchor).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 12).isActive = true
        
    }

    func configure(viewModel : ForecastTableViewCellViewModel) {
        iconImageView.image = UIImage(named: viewModel.weatherIconStr)
        highLabel.text = viewModel.highestTemp
        lowLabel.text = viewModel.lowestTemp
        dayLabel.text = viewModel.weekDay
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
    }

}

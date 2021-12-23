//
//  HourlyTableViewCell.swift
//  WeatherApp
//
//  Created by macbook on 7.12.2021.
//

import UIKit

class HourlyTableViewCell : UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    static let identifier = "HourlyTableViewCell"
    public var hourlyViewModels = [HourlyCollectionViewCellViewModel]()
    public let hourlyCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(red: 116/255, green: 178/255, blue: 240/255, alpha: 1)
        return collectionView
    }()
    
    private let topSepLine : UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    private let botSepLine : UIView = {
        let line = UIView()
        line.backgroundColor = .white
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(hourlyCollectionView)
        contentView.addSubview(botSepLine)
        contentView.addSubview(topSepLine)
        hourlyCollectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        hourlyCollectionView.dataSource = self
        hourlyCollectionView.delegate = self
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        hourlyCollectionView.translatesAutoresizingMaskIntoConstraints = false
        hourlyCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        hourlyCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        hourlyCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        hourlyCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        topSepLine.translatesAutoresizingMaskIntoConstraints = false
        topSepLine.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        topSepLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topSepLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        topSepLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        botSepLine.translatesAutoresizingMaskIntoConstraints = false
        botSepLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        botSepLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        botSepLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        botSepLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hourlyViewModels.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as! HourlyCollectionViewCell
        
        cell.configure(viewmodel: self.hourlyViewModels[indexPath.item])
        if indexPath.item == 0 {
            cell.hourLabel.text = "now"
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 7, height: 123)
    }

}

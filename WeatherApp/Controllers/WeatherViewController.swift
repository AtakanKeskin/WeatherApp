//
//  ViewController.swift
//  WeatherApp
//
//  Created by macbook on 5.12.2021.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    private let weatherTableView = UITableView()
    private var hourlyViewModels = [HourlyCollectionViewCellViewModel]()
    private var dailyViewModels = [ForecastTableViewCellViewModel]()
    private var location = CLLocation()
    private var cityName : String?
    
    private let sepLine : UIView = {
       let view = UIView()
       view.backgroundColor = .white
       return view
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 116/255, green: 178/255, blue: 240/255, alpha: 1)
        
        weatherTableView.register(HourlyTableViewCell.self, forCellReuseIdentifier: HourlyTableViewCell.identifier)
        weatherTableView.register(ForeCastTableViewCell.self, forCellReuseIdentifier: ForeCastTableViewCell.identifier)
        weatherTableView.dataSource = self
        weatherTableView.delegate = self
        weatherTableView.separatorStyle = .none
        setUpUI()
        getLocationandWeather()
    }


    private func setUpUI(){
        view.addSubview(weatherTableView)
        view.addSubview(sepLine)
        
        weatherTableView.isHidden = true
        
        weatherTableView.backgroundColor = UIColor(red: 116/255, green: 178/255, blue: 240/255, alpha: 1)
        
        weatherTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        weatherTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2).isActive = true
        
        sepLine.translatesAutoresizingMaskIntoConstraints = false
        sepLine.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sepLine.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sepLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepLine.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setUpTableHeaderView(curTemp : String, high: String, low : String, location : String, description: String) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height / 3.75))
        
        headerView.backgroundColor = UIColor(red: 116/255, green: 178/255, blue: 240/255, alpha: 1)
        let headerViewWidthSize = headerView.frame.size.width
        let headerViewHeightSize = headerView.frame.size.height
        
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 20, width: headerViewWidthSize-20, height: headerViewHeightSize / 8))
        let descriptionLabel = UILabel(frame: CGRect(x: 10, y: 25 + locationLabel.frame.size.height, width: headerViewWidthSize - 20 , height: headerViewHeightSize / 10))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 40 + descriptionLabel.frame.height + locationLabel.frame.size.height, width: headerViewWidthSize - 20, height: headerViewHeightSize/4))
        let highestLabel = UILabel(frame: CGRect(x: (headerViewWidthSize/2) - 20, y: 50 + tempLabel.frame.height + locationLabel.frame.size.height + descriptionLabel.frame.size.height, width: 100, height: headerViewHeightSize / 8))
        let lowestLabel = UILabel(frame: CGRect(x: (headerViewWidthSize / 2) - 80, y: 50 + tempLabel.frame.height + locationLabel.frame.size.height + descriptionLabel.frame.size.height, width: 100, height: headerViewHeightSize / 8))
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(descriptionLabel)
        headerView.addSubview(tempLabel)
        headerView.addSubview(highestLabel)
        headerView.addSubview(lowestLabel)
        
        locationLabel.textAlignment = .center
        descriptionLabel.textAlignment = .center
        tempLabel.textAlignment = .center
        highestLabel.textAlignment = .center
        lowestLabel.textAlignment = .center
        
        locationLabel.font = UIFont.boldSystemFont(ofSize: 32)
        descriptionLabel.font = UIFont.systemFont(ofSize: 22)
        tempLabel.font = UIFont.systemFont(ofSize: 72)
        highestLabel.font = UIFont.systemFont(ofSize: 20)
        lowestLabel.font = UIFont.systemFont(ofSize: 20)
        
        locationLabel.textColor = .white
        descriptionLabel.textColor = .white
        tempLabel.textColor = .white
        highestLabel.textColor = .white
        lowestLabel.textColor = .white
        
        locationLabel.text = location
        descriptionLabel.text = description
        tempLabel.text = "\(curTemp)º"
        highestLabel.text = "H:\(high)º"
        lowestLabel.text = "L:\(low)º"
        
        return headerView
    }
    
    private func updateUI(with model: ForecastModel){
        weatherTableView.isHidden = false
        
        var highestOfDay : Double = -1000
        var lowestOfDay : Double = 1000
        model.hourly[0...24].forEach{
            if $0.temp >= highestOfDay{
                highestOfDay = $0.temp
            }
            if $0.temp <= lowestOfDay{
                lowestOfDay = $0.temp
            }
        }
        
        
        weatherTableView.tableHeaderView = setUpTableHeaderView(curTemp: "\(Int(model.current.temp))", high: "\(Int(highestOfDay))", low: "\(Int(lowestOfDay))", location: self.cityName ?? "abc", description: "\(model.current.weather[0].main.rawValue)")
        
        weatherTableView.reloadData()
    }
    
    private func getWeather(){
        APIManager.shared.getWeatherForecast(lat: "\(self.location.coordinate.latitude)", lon: "\(self.location.coordinate.longitude)", completion:{
            [weak self] result in
            DispatchQueue.main.async {
            switch result{
                case .success(let weather_model):
                        self?.hourlyViewModels = weather_model.hourly.compactMap({
                            HourlyCollectionViewCellViewModel(imgStr: $0.weather[0].icon, hour: (self?.getHour(unixDate: Int($0.dt)))!, temp: "\(Int($0.temp))º")
                        })
                        self?.dailyViewModels = weather_model.daily.compactMap({
                    ForecastTableViewCellViewModel(weekDay: (self?.getWeekDay(unixDate: $0.dt))!, weatherIconStr: $0.weather[0].icon, highestTemp: "\(Int($0.temp.max))º", lowestTemp: "\(Int($0.temp.min))º")
                        })
                self?.updateUI(with: weather_model)
                case .failure(let error):
                    print(error)
                }
            }
        }
    )}
    
    func getLocationandWeather(){
        LocationManager.shared.getUserLocation { [weak self] location, cityName in
                self?.location = location
                self?.cityName = cityName
                self?.getWeather()
        }
    }
    
}


extension WeatherViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0
        {
            return 1
        }
        
        return dailyViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            
            cell.hourlyViewModels = self.hourlyViewModels
            cell.hourlyCollectionView.reloadData()
            return cell
        }
        

        let cell = tableView.dequeueReusableCell(withIdentifier: ForeCastTableViewCell.identifier, for: indexPath) as! ForeCastTableViewCell
        cell.configure(viewModel: self.dailyViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 125
        }
        
        return 40
    }
    
}


extension WeatherViewController {
    
    private func getHour(unixDate : Int) -> String{
        let dateUnix = Double(unixDate)
        let date = Date(timeIntervalSince1970: dateUnix)
        let hourComponent = Calendar.current.dateComponents([.hour], from: date)
        let hour = hourComponent.hour!
        let hourString = "\(hour)"
        return String(hourString)
    }
    
    private func getWeekDay(unixDate : Int) -> String{
        let dateUnix = Double(unixDate)
        let date = Date(timeIntervalSince1970: dateUnix)
        let weekdayComponents = Calendar.current.dateComponents([.weekday], from: date)
        let day = weekdayComponents.weekday!
        var dayStr = ""
        switch day{
        case 1 : dayStr = "Monday"
        case 2 : dayStr = "Tuesday"
        case 3 : dayStr = "Wednesday"
        case 4 : dayStr = "Thursday"
        case 5 : dayStr = "Friday"
        case 6 : dayStr = "Saturday"
        case 7 : dayStr = "Sunday"
        default:
            break
        }
        return dayStr
    }
}

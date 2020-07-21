//
//  ViewController.swift
//  iOSWeatherAPP
//
//  Created by Linda Silk on 2020/7/1.
//  Copyright © 2020 Linda Silk. All rights reserved.
//

import UIKit
import Alamofire
import Foundation
import SwiftyJSON
import CoreLocation
import NVActivityIndicatorView


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var searchText: UITextField!                             // 搜索
    @IBOutlet weak var backgroundView: UIView!                              // 背景
    
    // 基本天气信息
    @IBOutlet weak var locationLabel: UILabel!                              // 地点
    @IBOutlet weak var dayLabel: UILabel!                                   // 周几
    @IBOutlet weak var conditionImageView: UIImageView!                     // 天气图标
    @IBOutlet weak var conditionLabel: UILabel!                             // 天气类型
    @IBOutlet weak var temperatureLabel: UILabel!                           // 温度
    
    // 更多天气信息
    @IBOutlet weak var airLabel: UILabel!                                   // 空气指数
    @IBOutlet weak var airLevelLabel: UILabel!                              // 空气等级
    @IBOutlet weak var humidityLabel: UILabel!                              // 湿度
    @IBOutlet weak var pressureLabel: UILabel!                              // 气压
    @IBOutlet weak var waichuLabel: UILabel!                                // 外出建议
    @IBOutlet weak var kaichuangLabel: UILabel!                             // 开窗建议
    
    let gradientLayer = CAGradientLayer()                                   // 渐变层
    
    // 初始位置
    var lat = 30.67                                                         // 本地纬度
    var lon = 104.07                                                        // 本地经度
    
    var activityIndicator: NVActivityIndicatorView!                         // 加载动画
    var locationManager = CLLocationManager()                               // 获取用户位置
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.layer.addSublayer(gradientLayer)
        
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width-indicatorSize)/2, y: (view.frame.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)
        
        locationManager.requestWhenInUseAuthorization()                     // 当需要获取当前位置时，弹出提示
        activityIndicator.startAnimating()                                  // 开始加载动画
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }

    
    // 默认加载背景
    override func viewWillAppear(_ animated: Bool) {
        setPinkGradientBackground()
    }
    
    
    // 定位功能
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude                                  // 当前位置纬度
        lon = location.coordinate.longitude                                 // 当前位置经度
        let apiKey = "填入你的API_KEY"   // ❗️你的“OpenWeatherMap”账户的API_KEY❗️
        let url = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric"   // 封装成URL
        
        // 通过API获取并处理JSON数据
        // 此API提供方为"OpenWeatherMap"(https://openweathermap.org/)
        //
        // 参数说明：
        // lat: latitude 纬度
        // long: longitude 经度
        // appid: apikey 密钥
        // units=metric: 将华氏度转变为摄氏度
        //
        Alamofire.request(url).responseJSON { response in
            if response.result.isSuccess{                                   // 获取数据成功
                self.activityIndicator.stopAnimating()                      // 结束动画
                let json = JSON(response.result.value!)
                let location = json["name"].stringValue                     // 地点
                let weather = json["weather"][0]["main"].stringValue        // 天气类型
                let weatherImg = json["weather"][0]["icon"].stringValue     // 天气图标
                let temperature = json["main"]["temp"].doubleValue          // 气温
                let humidity = json["main"]["humidity"].stringValue         // 湿度
                let pressure = json["main"]["pressure"].stringValue         // 气压
                
                self.locationLabel.text = location
                self.conditionLabel.text = weather
                self.conditionImageView.image = UIImage(named: weatherImg)
                self.temperatureLabel.text = "\(Int(round(temperature)))"   // 将小数转化为整型
                self.humidityLabel.text = humidity
                self.pressureLabel.text = pressure
                
                // 显示是周几
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"                           // 设定格式
                self.dayLabel.text = dateFormatter.string(from: date)
                
                let suffix = weatherImg.suffix(1)                           // 根据JSON数据中iconName的后缀来确定界面的颜色
                if(suffix == "n"){                                          // 后缀为n，即night，设定背景为灰色渐变
                    self.setBlueGradientBackground()
                }else{                                                      // 后缀为d，即day，设定背景为蓝色渐变
                    self.setPinkGradientBackground()
                }
            } else {                                                        // 获取数据失败
                self.activityIndicator.stopAnimating()                      // 结束动画
                print("通过Alamofire获取数据出错了: ", response.error as Any)
            }
        }
        self.locationManager.stopUpdatingLocation()                         // 当获取当前位置后，停止实时更新位置，以便节省电量
    }
    
    
    // 按下”搜索“按钮后的行为
    @IBAction func searchButton(_ sender: Any) {
        let search = searchText.text!                                       // 搜索栏输入的数据
        let appid = 00000000                // ❗️改为你的“天气API”账户ID,不用加引号❗️
        let appsecret = "你的app_secret"     // ❗️改为你的“天气API”账户密钥❗️
        let url = "http://www.tianqiapi.com/api?version=v9&appid=\(appid)&appsecret=\(appsecret)&city=\(search)"    // 封装成URL
        let trimmedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!    // 存在中文，对URL进行编码
        
        print("您搜索的城市是:", search as Any)                              // 测试能否成功获取输入数据
        
        activityIndicator.startAnimating()                                  // 加载动画
        
        // 通过API获取并处理JSON数据
        // 此API提供方为"天气API"(https://www.tianqiapi.com/)
        //
        // 参数说明:
        // appid: 用户ID
        // appsecret: 密钥
        // cityid: 城市ID
        //
        Alamofire.request(trimmedUrl, method: .get).responseJSON { response in
            if response.result.isSuccess{                                   // 获取数据成功
                self.activityIndicator.stopAnimating()                      // 结束动画
                print("成功得到JSON数据了!")
                
                // 用变量存储需要的JSON数据
                let json = JSON(response.result.value!)
                let location = json["city"].stringValue                     // 城市名称
                let day = json["data"][0]["week"].stringValue               // 周几
                let weather = json["data"][0]["wea"].stringValue            // 天气类型
                let img = json["data"][0]["wea_img"].stringValue            // 天气图片
                let temp = json["data"][0]["tem"].stringValue               // 当前温度
                
                let humidity = json["data"][0]["humidity"].stringValue      // 湿度
                let pressure = json["data"][0]["pressure"].stringValue      // 气压
                let air = json["aqi"]["air"]                                // 空气指数
                let airLevel = json["aqi"]["air_level"].stringValue         // 空气等级
                let waichu = json["aqi"]["waichu"].stringValue              // 外出建议
                let kaichuang = json["aqi"]["kaichuang"].stringValue        // 开窗建议

                // 测试
                print("\(search)今天\(weather), 气温\(temp)度")
                
                // 将存储的JSON数据展示在界面上
                self.locationLabel.text = location
                self.dayLabel.text = day
                self.conditionLabel.text = weather
                self.temperatureLabel.text = temp
                self.conditionImageView.image = UIImage(named: img)
                
                self.humidityLabel.text = humidity
                self.pressureLabel.text = pressure
                self.airLabel.text = air.stringValue
                self.airLevelLabel.text = airLevel
                self.waichuLabel.text = waichu
                self.kaichuangLabel.text = kaichuang
                
                // 根据空气指数设定背景色
                if(Int(round(air.doubleValue)) > 60){
                    self.setGrayGradientBackground()                        // 大于60设定灰色渐变
                }else{
                    self.setPinkGradientBackground()                        // 小于等于60设定蓝色渐变
                }
            } else {                                                        // 获取数据失败
                self.activityIndicator.stopAnimating()                      // 结束动画
                print("通过Alamofire获取数据出错了: ", response.error as Any)
            }
        }
    }
    
    
    // 设置背景为蓝粉色渐变
    func setPinkGradientBackground() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor                  // 蓝色
        let bottomColor = UIColor(red: 241.0/255.0 , green: 158.0/255.0, blue: 194.0/255.0, alpha: 1.0).cgColor     // 粉色
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    
    // 设定背景为蓝灰渐变
    func setBlueGradientBackground() {
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor                  // 蓝色
        let bottomColor = UIColor(red: 72.0/255.0 , green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    
    // 设置背景为灰色渐变
    func setGrayGradientBackground() {
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0 , green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
}

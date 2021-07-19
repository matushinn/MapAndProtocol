//
//  ViewController.swift
//  MapAnd Protocol
//
//  Created by 大江祥太郎 on 2021/07/18.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController,UIGestureRecognizerDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locManager:CLLocationManager!
    
    @IBOutlet weak var addresLabel: UILabel!
    
    @IBOutlet weak var settingBUtton: UIButton!
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    var addresssString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        settingBUtton.backgroundColor = .white
        settingBUtton.layer.cornerRadius = 20.0
        
        
    }

    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
        
        //タップを開始した
        if sender.state == .began{
            
        }else if sender.state == .ended{
            //タップを終了
            //viewの中のlocationをtapPointに入れる
            let tapPoint = sender.location(in: view)
            
            //タップした位置を指定して、MKMapvire上の緯度、経度を取得する
            let center = mapView.convert(tapPoint, toCoordinateFrom:mapView)
            let lat = center.latitude
            let log = center.longitude
            
            //経度、緯度から住所に変換する
            convert(lat: lat, log: log)
            
            
            
        }
       
    }
    
    //lat=緯度,log=経度を扱うクラス
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        
        //クロージャーの中に書いてあるメンバ変数は、selfを書かないといけない。
        //緯度、経度から住所を取得するときのお決まりの処理
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        
        //クロージャー
        //placeMark,errorに値が入ったら中の処理が呼ばれる。中の処理は後での処理になる。
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if let placeMark = placeMark{
                if let pm = placeMark.first{
                    //locality=市、区
                    if pm.administrativeArea != nil || pm.locality != nil {
                        self.addresssString = pm.name! + pm.administrativeArea! + pm.locality!
                    }else{
                        self.addresssString = pm.name!
                    }
                    
                    self.addresLabel.text = self.addresssString
                }
            }
        }
        
        
        
    }

}

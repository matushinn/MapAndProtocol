//
//  NextViewController.swift
//  MapAnd Protocol
//
//  Created by 大江祥太郎 on 2021/07/19.
//

import UIKit

protocol SearchLocationDelegate {
    func searchLocation(idoValue:String,keidoValue:String)
}

class NextViewController: UIViewController {
    
    @IBOutlet weak var idoTextField: UITextField!
    
    @IBOutlet weak var keidoTextField: UITextField!
    
    var delegate:SearchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okAction(_ sender: Any) {
        
        //入力された値を取得
        let idoValue = idoTextField.text!
        let keidoValue = keidoTextField.text!
       
        
        //両方のTFが空でなければ戻る
        if idoTextField.text != nil && keidoTextField.text != nil {
            //デリゲートメソッドの引数に入れる
            delegate?.searchLocation(idoValue: idoValue, keidoValue: keidoValue)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
   
}

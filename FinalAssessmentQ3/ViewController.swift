//
//  ViewController.swift
//  FinalAssessmentQ3
//
//  Created by jamespoyu on 2016/8/6.
//  Copyright © 2016年 AlphaCamp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    @IBAction func postData(sender: AnyObject) {
        let postUrl = "https://httpbin.org/post"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone.localTimeZone()
        let currentTime = dateFormatter.stringFromDate(NSDate())
        let parameters = ["time": "\(currentTime)"]
        print(currentTime)
        
        Alamofire.request(.POST, postUrl, parameters: parameters).responseJSON {
            response in
            print("回傳值為\(response)")
            if let data = response.result.value {
                let content = JSON(data)
                let spendingTime = dateFormatter.dateFromString(String(content["form"]["time"]))
                let timeGap = NSString(format:"%.3f", -(spendingTime?.timeIntervalSinceNow)!)
                NSLog("花了\(timeGap)秒")
                
            }
            
            
        }

        
    }

    @IBAction func getdata(sender: AnyObject) {
     let urlString = "https://httpbin.org/get"
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                if let data = response.result.value {
                    let json = JSON(data)
                    let origin = json["origin"].stringValue
                    NSLog("origin data is \(origin)")
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  Assignment10
//
//  Created by admin on 12/1/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //URL
        let url = URL(string: "https://ocr-text-extractor.p.rapidapi.com/detect-text-from-image-uri")
        
        guard url != nil else {
             print("Error creating url object")
            return
        }
        
        //URL request
        var request = URLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        
        //Specify the header
        let headers = ["content-type": "application/json",
                       "accept": "string",
                       "x-rapidapi-key": "SIGN-UP-FOR-KEY",
                       "x-rapidapi-host": "ocr-text-extractor.p.rapidapi.com"]
        
        request.allHTTPHeaderFields = headers
        
        //Specify the body
        let jsonObject = [ "Uri": "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png",
                            "Language": "eng",
                            "DetectOrientation": false,
                            "Scale": false,
                            "IsTable": false,
        "OcrEngine": "Version2"] as [String:Any]
        
        do {
        let requestBody = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
            
            request.httpBody = requestBody
        }
        catch {
            print("Error creating the data Object from json")
        }
        
        //set the request type
        request.httpMethod = "POST"
        
        // Get the URL session
        let session = URLSession.shared
        
        
        //Create the data task
        let dataTask = session.dataTask(with: request){ (data, response, error) in
            
            //Check for errors
            if error == nil && data != nil {
                //Try to parse that data
                do {
                let dictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                    print(dictionary)
                }
                catch {
                    print("Error parsing response data")
                }
            }
        }
        
        //Fire the data task.
        dataTask.resume()
    }
 

}


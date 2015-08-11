//
//  ViewController.swift
//  UpdateDatabase
//
//  Created by Alan Randell-Chen on 8/10/15.
//  Copyright (c) 2015 Alan Randell-Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    func postToServerFunction() {
        println("Button Pressed")
        
        var response: NSHTTPURLResponse
        var url = NSURL(string: "http://nickcarraway.org/index.php?user=47&height=144&weight=5430000000021+&functionused=INSERT&submit=Go")!
        
        let request = NSURLRequest(URL: url)
        
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
        println("postToServerFunction worked")
        println(url)
        
//        var request:NSMutableURLRequest = NSMutableURLRequest(URL:url)

//        var bodyData = "data=something"
//        request.HTTPMethod = "GET"
//        
//        request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
//            {
//                (response, data, error) in
//                println(response)
//                
//        }
//        
////        if let HTTPResponse = response as NSHTTPURLResponse {
//            let statusCode = HTTPResponse.statusCode
//            
//            if statusCode == 200 {
//                // Yes, Do something.
//            }
//        }
    }
    
    @IBAction func postToServerButton(sender: AnyObject) {
        postToServerFunction()
        println("postToServerButton")

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


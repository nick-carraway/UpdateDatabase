//
//  ViewController.swift
//  UpdateDatabase
//
//  Created by Alan Randell-Chen on 8/10/15.
//  Copyright (c) 2015 Alan Randell-Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // Task as of 8/12/15: Create three view controllers.  Navigate between these three in whatever way (either using table view or not);  create three diff user interface experiences.  One is if you open and hit button it will update data base; another will be insert; another will be select.  See if you can get select to show in screen; see if you can get update to show update was successful; see if you can sho.  Need to add lines of code to print to console to let us know that the "navigation is driving propertly'--probably put this into ViewDidLoad.  Don't worry about taking variables from textfields.
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var dataToUpdateTextField: UITextField!
    @IBOutlet weak var selectDataOutputTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var myArray = []
    
    @IBAction func userFieldUpdateButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func heightFieldUpdateButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func weightFieldUpdateButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func insertChosen(sender: AnyObject) {
        println("User would like to insert data.")
    }
    
    @IBAction func selectChosen(sender: AnyObject) {
        println("User would like to select data.")
    }
    
    @IBAction func updateChosen(sender: AnyObject) {
        println("User would like to update data.")
    }

    @IBAction func insertButtonPressed(sender: AnyObject) {
        var userInput = userTextField.text
        var heightInput = heightTextField.text
        var weightInput = weightTextField.text
        
        insertToServerFunction(userInput, heightParameter: heightInput, weightParameter: weightInput)
        
        var alert = UIAlertController(title: "Data added", message: "You have added user " + userInput + ".  Height is " + heightInput + ".  Weight is " + weightInput + ".", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Roger roger", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func selectButtonPressed(sender: AnyObject) {
        //selectToServerFunction()
        println("Data selected.")
    }
    
    //updateButtonPressed will be a tricky one to solve.
    @IBAction func updateButtonPressed(sender: AnyObject) {
        //updateToServerFunction()
    }
    
    func insertToServerFunction(userParameter: String, heightParameter: String, weightParameter: String) {
        
        //var response: NSHTTPURLResponse
        var url = NSURL(string: "http://nickcarraway.org/index.php?user=" + userParameter + "&height=" + heightParameter + "&weight=" + weightParameter + "+&functionused=INSERT&submit=Go")!
        
        let request = NSURLRequest(URL: url)
        
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
        println("insertToServerFunction worked")
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
    
    func selectToServerFunction() {
        // var response: NSHTTPURLResponse
        
        // Step 1: input the target URL into a variable called "url"; this variable will be a string.  Also create a variable that will store error if the URL request fails.
        var url = NSURL(string: "http://nickcarraway.org/tabletest.php")!
        
        var parseError: NSError?
        
        // var url = NSURL(string: "http://nickcarraway.org/index.php?user=&height=&weight=+&functionused=DISPLAY&submit=Go")!
        
        // Step 2: input the target URL ("url") into an NSURLRequest function that converts this string to a usable URL.  This converted URL will be stored as a variable known as "request"
        let request = NSURLRequest(URL: url)
        let request1 = NSMutableURLRequest(URL: url)
        
        // This step might not be necessary.   Step 3: create a connection using URL connection from the previous step.
//        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
        // Step 4: if there is no data from the session created with the URL, then print an error.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request1) {
            data, response, error in
            
            if data == nil {
                println("request failed at line 120 \(error)")
                return
        }
            
        // Step 5: create a JSON object that will store the data requested.
        
        if let json = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &parseError) as? [String: String] {
                
            if let name = json["name"] {
                println("name = \(name)")   // if everything is good, you'll see "Alan!"
            }
            
            println("test to see if if statement called;  line 132")
                
        } else {
            
        // println("parsing error: \(parseError)")
        // Step 6: create a variable called responseString that will store the data that gets pulled from URL
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            println("raw response: \(responseString)") // this code prints a raw response of HELP as of 8/13/15 with a type of OPTIONAL???  May need to do what is known as "forced unwrapping of hte optional"
            
            println(toString(responseString.dynamicType)) // determines the type of the responseString; spits out Metadata for some reason
           
        // Step 7: convert the data to string and display the data in UITextView
            
            dispatch_sync(dispatch_get_main_queue()) {
                // place code for main thread here
                
                self.selectDataOutputTextView.text = toString(responseString)
            }
            
        // let json = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &parseError) as? [String: String]  //This line of code may not even be necessary
            
        // println(json) // printing of JSON as of 8/13/15 for some reason returned a nil
        // conclusion of test code

        //  self.selectDataOutputTextView.text = responseString //This line is causing the issue--the code runs, and the application will not terminate so long as this line is commended out.
        
            }
        }
    
        task.resume()
        
        
    }
    
    func updateToServerFunction(dataToUpdate: String) {
        // var response: NSHTTPURLResponse
        var url = NSURL(string: "http://nickcarraway.org/index.php?user=1&height=&weight=+889247891798432&functionused=UPDATE&submit=Go")!
        
        let request = NSURLRequest(URL: url)
        
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
        println("updateToServerFunction worked")
        println(url)
    }
    
    @IBAction func insertBackButtonPressed(sender: AnyObject) {
        println("insertBackButtonPressed")
    }
    
    @IBAction func selectBackButtonPressed(sender: AnyObject) {
        println("selectBackButtonPressed")
    }
    
    @IBAction func updateBackButtonPressed(sender: AnyObject) {
        println("updateBackButtonPressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //start of temporary move of block 1.5 of code to ViewDidLoad
        var urlString = NSURL(string: "http://nickcarraway.org/tabletest.php")!
        var myAsset = String(contentsOfURL: urlString, encoding: NSUTF8StringEncoding, error: nil)!
        myArray = split(myAsset){$0 == ","}.map{String($0)}
        
   
        //
        //      println("My asset is " + myAsset)
        // end of temporary move of block 1.5 of code to ViewDidLoad

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //    func getallrecords(){
    //        let url = NSURL(string: "http://www.nickcarraway.org/index.php")
    //        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
    //            var d = NSString(data: data, encoding: NSUTF8StringEncoding)
    //            var arr = d!.componentsSeparatedByString("<") // spliting the incoming string from "<" operator because before that operator is our required data and storing in array
    //            var dataweneed:NSString = arr[0] as NSString // arr[0] is the data before "<" operator and arr[1] is actually no use for us
    //            let data = NSJSONSerialization.JSONObjectWithData(dataweneed.dataUsingEncoding(NSUTF8StringEncoding)!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSArray
    //            for dd in data {
    //                var user: String = dd["user"]! as String
    //                var height: String = dd["height"]! as String
    //                var weight: String = dd["weight"]! as String
    //                println("User is : \(user)")
    //                println("Height is : \(height)")
    //                println("Weight is : \(weight)")
    //            }
    //        }
    //            task.resume()
    //    }
    
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myArray.count
    }
    
    // This displays the reusable cells
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        var urlString = NSURL(string: "http://nickcarraway.org/tabletest.php")!
        var myAsset = String(contentsOfURL: urlString, encoding: NSUTF8StringEncoding, error: nil)!

        //The println will display the rows of each cell
        
        println(indexPath.row)
        
        
        /* start of temporary move of block 1.5 of code to ViewDidLoad


        
        //      println(urlString)
        
        // This next line of code will convert contents of URL from string to array
        

//
//      println("My asset is " + myAsset)
  end of temporary move of block 1.5 of code to ViewDidLoad */
        
        
        //This next line of code will "split" the array using commas as delimiters
        
        myArray = split(myAsset){$0 == ","}.map{String($0)}
        
        // This next line of code will input the individual array values into the cell
        
        cell.taskLabel.text = myArray[indexPath.row] as String
        
        return cell
        
//        for(var stringCounter = 0; stringCounter < fullNameArr.number(); stringCounter++) {
//            myArray[stringCounter] = full
//        }
        
//        
//        println(myArray[0])
//        println(myArray[1])
//        println(myArray[2])
//        println(myArray[3])
//        
//        cell.taskLabel.text = myArray[0]
        
        
        /* Temporary removal start (8/17/15)
        // test code 1.1 start
        
        var url = NSURL(string: "http://nickcarraway.org/tabletest.php")!
        //        var url = NSURL(string: "http://nickcarraway.org/index.php?user=&height=&weight=+&functionused=DISPLAY&submit=Go")!
        let request = NSURLRequest(URL: url)
        
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
        let request1 = NSMutableURLRequest(URL: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request1) {
            data, response, error in
            
            if data == nil {
                println("request failed \(error)")
                return
            }
            
            var parseError: NSError?
            if let json = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &parseError) as? [String: String] {
                
                if let name = json["name"] {
                    println("name = \(name)")   // if everything is good, you'll see "Alan!"
                }
                
            } else {
                // println("parsing error: \(parseError)")
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                let characters = Array(arrayLiteral: responseString)
                println(characters[0])
                
                
                
                //start of test code 1.3
                
                let fullName = "First Last"
                let fullNameArr = split(responseString){$0 == ","}.map{String($0)}
                
                println(fullNameArr[0]) // First
                fullNameArr[1] // Last
                
                //end of test code 1.3
                
                
                println("raw response.  Now we have changed the raw reponse an array. \(responseString)") // Prints responseString to console
                
                println(toString(responseString.dynamicType)) // determines the type of the responseString; spits out Metadata for some reason
                
                
                dispatch_sync(dispatch_get_main_queue()) {
                    // place code for main thread here
                    
                    cell.taskLabel.text = toString(responseString)
                }

            }
        }
        
        task.resume()

        
        // test code 1.1 end
        
        return cell
        
        //this part of the code regenerates the reusable cells
    
        Temporary removal end (8/17/15)

    */

    }

    
    // UITableViewDelegate; activated when we select a specific row.
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


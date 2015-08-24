//
//  ViewController.swift
//  UpdateDatabase
//
//  Created by Alan Randell-Chen on 8/10/15.
//  Copyright (c) 2015 Alan Randell-Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Task as of 8/12/15: Create three view controllers.  Navigate between these three in whatever way (either using table view or not);  create three diff user interface experiences.  One is if you open and hit button it will update data base; another will be insert; another will be select.  See if you can get select to show in screen; see if you can get update to show update was successful; see if you can sho.  Need to add lines of code to print to console to let us know that the "navigation is driving propertly'--probably put this into ViewDidLoad.  Don't worry about taking variables from textfields.
    
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var dataToUpdateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var swiperLabel: UILabel!
    
    var myArray = []
    var count = -3
    var maxCount = 0
    var urlString = NSURL(string: "http://nickcarraway.org/tabletest.php")!
    var myAsset = ""
    var swipeCount = 3
    var logoImages: [UIImage] = [(UIImage(named: "Aardvark")!),
                                (UIImage(named: "Barracuda.jpeg")!),
                                (UIImage(named: "Chimp.jpeg")!),
                                (UIImage(named: "Dingo.jpeg")!),
                                (UIImage(named: "Egret.jpg")!),
                                (UIImage(named: "Fossa.jpg")!),
                                (UIImage(named: "Gerbil.jpeg")!),
                                (UIImage(named: "Hippo.jpg")!)
                                ]
    
    
    
    @IBAction func userFieldUpdateButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func heightFieldUpdateButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func weightFieldUpdateButtonPressed(sender: AnyObject) {
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
        // refresh the database so Select View has the most current data.
        
        myAsset = String(contentsOfURL: urlString, encoding: NSUTF8StringEncoding, error: nil)!
        myArray = split(myAsset){$0 == ","}.map{String($0)}
        maxCount = myArray.count - 1
        println(maxCount)
        count = 0

    }
    
    
    @IBAction func createSubviewButtonPressed(sender: AnyObject) {
        // start of test code 2.6 on 8/21/15 to programatically create image subview
        
            // start of test code 3.1 on 8/21/15 to programatically create imageviews
            let testFrame : CGRect = CGRectMake(20,450,320,200)
            var testView : UIView = UIView(frame: testFrame)
            var bgImage: UIImageView?
            var image: UIImage = logoImages[1]
            bgImage = UIImageView(image: image)
            bgImage!.frame = CGRectMake(40,550,100,100)
            // end of test code 3.1 on 8/21/15 to programatically create imageviews

        
        
        testView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
//        testView.alpha=0.5
        
        
        self.view.addSubview(testView)
        self.view.addSubview(bgImage!)
        
        
        // end of test code 2.6 on 8/21/15 to programatically create image subview
        
        
        
        
        
        // start of test code 2.9 o 8/21/15 to programatically create label in subview
        
        
        
        var label = UILabel(frame: CGRectMake(100, 480, 190, 21))
        label.text = "I am a test label"
        self.view.addSubview(label)
        
        // end of test code 2.9 o 8/21/15 to programatically create label in subview
        
    }

    
    
    //updateButtonPressed will be a tricky one to solve.
    @IBAction func updateButtonPressed(sender: AnyObject) {
        //updateToServerFunction()
    }
    
    func insertToServerFunction(userParameter: String, heightParameter: String, weightParameter: String) {
        var url = NSURL(string: "http://nickcarraway.org/index.php?user=" + userParameter + "&height=" + heightParameter + "&weight=" + weightParameter + "+&functionused=INSERT&submit=Go")!
        
        let request = NSURLRequest(URL: url)
        
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
        println("insertToServerFunction worked")
        println(url)
    }
    
    func selectToServerFunction() {
        

        
        
//        var url = NSURL(string: "http://nickcarraway.org/tabletest.php")!
        
        var parseError: NSError?
 
        // Step 2: input the target URL ("url") into an NSURLRequest function that converts this string to a usable URL.  This converted URL will be stored as a variable known as "request"
        let request = NSURLRequest(URL: urlString)
        let request1 = NSMutableURLRequest(URL: urlString)
        
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
         
        // Step 6: create a variable called responseString that will store the data that gets pulled from URL
            
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                println("raw response: \(responseString)") // this code prints a raw response of HELP as of 8/13/15 with a type of OPTIONAL???  May need to do what is known as "forced unwrapping of hte optional"
                
                println(toString(responseString.dynamicType)) // determines the type of the responseString; spits out Metadata for some reason
               
            // Step 7: convert the data to string and display the data in UITextView
                
                dispatch_sync(dispatch_get_main_queue()) {
                    // place code for main thread here
                    
//                    self.selectDataOutputTextView.text = toString(responseString)
                }
            }
        }
    
    }
    
    func updateToServerFunction(dataToUpdate: String) {
        var url = NSURL(string: "http://nickcarraway.org/index.php?user=1&height=&weight=+889247891798432&functionused=UPDATE&submit=Go")!
        
        let request = NSURLRequest(URL: url)
        
        let connection = NSURLConnection(request: request, delegate:nil, startImmediately: true)
        
        println("updateToServerFunction worked")
        
        println(url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        // start of temporary code block 1.88 to test swipe functionality per Seaton Gras request (8/18/15)
        
        var leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        var rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
        
        leftSwipe.direction = .Left
        rightSwipe.direction = .Right
        
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)

        // end of temporary code block 1.88 to test swipe functionality per Seaton Gras request (8/18/15)
        
        //start of temporary move of block 1.5 of code to ViewDidLoad
        myAsset = String(contentsOfURL: urlString, encoding: NSUTF8StringEncoding, error: nil)!
        myArray = split(myAsset){$0 == ","}.map{String($0)}
        maxCount = myArray.count - 1
        println(maxCount)
        
        // end of temporary move of block 1.5 of code to ViewDidLoad
   
    }
    
    

        
        
        
    // start of temporary code block 1.99 to install a handleSwipes function

    
    func handleSwipes(sender:UISwipeGestureRecognizer) {
        
        // start of test code 2.5 8/21/15
        
        myAsset = String(contentsOfURL: urlString, encoding: NSUTF8StringEncoding, error: nil)!
        myArray = split(myAsset){$0 == ","}.map{String($0)}
        maxCount = myArray.count - 1
        println(maxCount)
        
        // end of test code 2.5 8/21/15
        
        
        //swipe right is causing problems; remember indexing starts at zero;
        // TODO as of 8/21/15: fix the swipe indexing so that I can switch directions without falling out of index range.  Also, I need to fix issue where the wrapping results in blank label

        // TODO as of 8/21/15: it looks like issue with type casting right now is that I cannot switch between strings and numbers--

        if (sender.direction == .Right) {
//
//            if swipeCount == (maxCount-1) {
//                swipeCount = -1
//            }
//            swipeCount++
//            var myArrayValue = myArray[swipeCount]
//            swiperLabel.text = String(myArrayValue as NSString)
//    

            // start of temporarly block of code 3.2 to handle switching UIview image upon right swipe
            
            // start of test code 3.1 on 8/21/15 to programatically create imageviews
            let testFrame : CGRect = CGRectMake(20,450,320,200)
            var testView : UIView = UIView(frame: testFrame)
            var bgImage: UIImageView?
            var image: UIImage = logoImages[1]
            bgImage = UIImageView(image: image)
            bgImage!.frame = CGRectMake(40,550,100,100)
            // end of test code 3.1 on 8/21/15 to programatically create imageviews
            
            testView.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
//            testView.alpha=0.5
            
            self.view.addSubview(testView)
            self.view.addSubview(bgImage!)
            
            // end of test code 3.1 on 8/21/15 to programatically create imageviews
            
            // end of temporarly block of code 3.2 to handle switching UIview image upon right swipe
            
            // start of test code 2.9 o 8/21/15 to programatically create label in subview
            
            var label = UILabel(frame: CGRectMake(100, 480, 190, 21))
            label.text = myAsset
            self.view.addSubview(label)
            
            // end of test code 2.9 o 8/21/15 to programatically create label in subview
            
        }
        
        if (sender.direction == .Left) {
            var bgImage: UIImageView?
            let testFrame : CGRect = CGRectMake(20,450,320,200)
            var testView : UIView = UIView(frame: testFrame)
            testView.backgroundColor = UIColor(red: 0.8, green: 0.5, blue: 0.5, alpha: 1.0)
            self.view.addSubview(testView)
            
            // start of test code block 3.5 on 8/23/15 to programmaticlly update labels based on array values
            
            if swipeCount == (maxCount-1) {
                swipeCount = -1
            }
            swipeCount++
            
            var myArrayValue = myArray[swipeCount]
            var image: UIImage = logoImages[swipeCount]
            swiperLabel.text = String(myArrayValue as NSString)

            var label = UILabel(frame: CGRectMake(100, 480, 190, 21))
            label.text = String(myArrayValue as NSString)
            self.view.addSubview(label)
            
            bgImage = UIImageView(image: image)
            bgImage!.frame = CGRectMake(40,550,100,100)
            self.view.addSubview(bgImage!)
            // end  of test code block 3.5 on 8/23/15 to programmaticlly update labels based on array values
            

            
            
        }
    }
    // end of temporary code block 1.99 to install a handleSwipes function
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This function returns the number of cells needed, which as of 8/18/15 will be the number of pieces of data divided by 3 since each cell currently has three labels.
        
        return (myArray.count/3)
    }
    
    // This displays the reusable cells
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        count = count + 3
        
        
        // TODO: these next three lines of code will effectively cap the bottom of hte list, but it resets all cells above to the last cell when you scroll back up (8/18/15)
        if count == maxCount {
            count = (count - 3)
        }

        // TODO: these previous three lines of code will effectively cap the bottom of hte list, but it resets all cells above to the last cell when you scroll back up (8/18/15)
        
        
        
        /* Start of chunk of code that may not be necessary because we can move this to ViewDidLoad
        
        var urlString = NSURL(string: "http://nickcarraway.org/tabletest.php")!
        var myAsset = String(contentsOfURL: urlString, encoding: NSUTF8StringEncoding, error: nil)!
        
        
        // End of chunk of code that may not be necessary because we can move this to ViewDidLoad */
        
        //The println will display the rows of each cell
        //println(indexPath.row)
        
        //This next line of code will "split" the array using commas as delimiters
        
//        myArray = split(myAsset){$0 == ","}.map{String($0)}

     
        cell.userLabel.text = (myArray[count] as String)
        cell.heightLabel.text = (myArray[count + 1] as String)
        cell.weightLabel.text = (myArray[count + 2] as String)
        
        return cell
    }
 
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


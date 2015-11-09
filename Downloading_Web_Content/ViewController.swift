//
//  ViewController.swift
//  Downloading_Web_Content
//
//  Created by Jason Shultz on 11/8/15.
//  Copyright © 2015 HashRocket. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // create a url
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/6/6a/Johann_Sebastian_Bach.jpg")
        
        // make a url request. use ! because we know that the url is a url
        let urlRequest = NSURLRequest(URL: url!)
        
        // typically, you will use asynchronous requests.
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            if error != nil {
                print(error)
            } else {
                
                if let bach = UIImage(data: data!) {
                    
                    // we comment this out because we are testing the code below where we are getting the image from the file system instead.
                    // self.image.image = bach
                    
                    
                    // create variable we will store path into.
                    var documentsDirectory:String?
                    
                    // create a variable, then search for the user's documents directory.
                    var paths:[AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                    
                    // did we find a directory? of course we did.
                    if paths.count > 0 {
                        // take the path, set it as a string and store it in the variable.
                        documentsDirectory = paths[0] as? String
                        
                        // now we can create a save path.
                        let savePath = documentsDirectory! + "/bach.jpg"
                        
                        // now we actually save the file.
                        NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                        
                        // now we are going to pull it from the file system.
                        self.image.image = UIImage(named: savePath)
                    }
                    
                    
                }
                
                
                
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


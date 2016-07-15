//
//  ViewController.swift
//  Good Morning
//
//  Created by Dubois Grayson on 7/11/16.
//  Copyright © 2016 Grayson Dubois. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CocoaLumberjack

class ViewController: UIViewController {

    @IBOutlet var qodLabel: UILabel!
    @IBOutlet var vodLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var URL = NSURL(string: "http://quotes.rest/qod.json")!
        var request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case .Success(let response):
                let json = JSON(response)
                //DDLogDebug("\(json)")
                
                let quote = json["contents"]["quotes"][0]["quote"].stringValue
                let author = "\n\n - \(json["contents"]["quotes"][0]["author"].stringValue)"
                
                self.qodLabel?.text = quote + author
            case .Failure(let error):
                DDLogError("\(error)")
            }
        }
        
        URL = NSURL(string: "http://labs.bible.org/api/?passage=votd&type=json")!
        request = NSMutableURLRequest(URL: URL)
        request.HTTPMethod = "GET"
        
        Alamofire.request(request).responseJSON { response in
            switch response.result {
            case .Success(let response):
                let json = JSON(response)
                //DDLogDebug("\(json)")
                
                let text = json[0]["text"].stringValue
                let bookName = json[0]["bookname"].stringValue
                let chapter = json[0]["chapter"].stringValue
                let verse = json[0]["verse"].stringValue
                
                self.vodLabel?.text = "\(text)\n\n - \(bookName) \(chapter): \(verse)"
                
            case .Failure(let error):
                DDLogError("\(error)")
            }
        }
    }
}


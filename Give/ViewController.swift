//
//  ViewController.swift
//  Give
//
//  Created by Jonathan Grant on 7/17/15.
//  Copyright (c) 2015 Jonathan Grant. All rights reserved.
//

import UIKit
import GoogleMobileAds
import Social
import MessageUI
import SwiftAddressBook

class ViewController: UIViewController {

    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var adView: GADBannerView!
    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var refresh: UIButton!
    @IBOutlet weak var forward: UIButton!
    
    func webViewDidStartLoad(_ : UIWebView) {
        actInd.startAnimating()
    }
    
    func webViewDidFinishLoad(_ : UIWebView) {
        actInd.stopAnimating()
    }
    
    func getAllContacts() {
        swiftAddressBook?.requestAccessWithCompletion({ (success, error) -> Void in
            if success {
                //do something with swiftAddressBook
                if let people = swiftAddressBook?.allPeople {
                    for person in people {
                        //print("\((person.emails[0])!)"
                    }
                }
            }
            else {
                //no success. Optionally evaluate error
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "http://whomentors.com/project/campaign/3.html?layout=single#single")
        let requestObj = NSURLRequest(URL: url!)
        myWebView.loadRequest(requestObj)
        
        setUpAds()
        setUpIcons()
    }
    
    func setUpIcons() {
        back.titleLabel!.font = UIFont(name: "FontAwesome", size: 27)
        refresh.titleLabel!.font = UIFont(name: "FontAwesome", size: 27)
        forward.titleLabel!.font = UIFont(name: "FontAwesome", size: 27)
        back.setTitle("\u{f060}", forState: .Normal)
        forward.setTitle("\u{f061}", forState: .Normal)
        refresh.setTitle("\u{f021}", forState: .Normal)
    }
    
    func setUpAds() {
        adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adView.rootViewController = self
        let request: GADRequest = GADRequest()
        request.testDevices = ["2077ef9a63d2b398840261c8221a0c9b", "ca-app-pub-3940256099942544/2934735716"]
        adView.loadRequest(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Web Methods
    @IBAction func back(sender:AnyObject) {
        if myWebView.canGoBack{
            myWebView.goBack()
        }
    }
    
    @IBAction func forward(sender:AnyObject) {
        if myWebView.canGoForward{
            myWebView.goForward()
        }
    }
    
    @IBAction func refresh(sender:AnyObject) {
        myWebView.reload()
    }

    //Sharing
    @IBAction func shareButtonClicked(sender: UIButton)
    {
        let textToShare = "Swift is awesome!  Check out this website about it!"
        
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/")
        {
            let objectsToShare = [textToShare, myWebsite]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            activityVC.excludedActivityTypes = [UIActivityTypeAddToReadingList]
            //
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
}

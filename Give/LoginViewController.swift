//
//  LoginViewController.swift
//  Give
//
//  Created by shiga yuichi on 2015/07/17.
//  Copyright (c) 2015年 Jonathan Grant. All rights reserved.
//

import Foundation
import Parse

// http://www2.gtlaw.com/practices/immigration/hr/guides/PermissibleActivities.pdf

class LoginViewController: UIViewController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func didLoginTap(sender: AnyObject) {
        
       // openProfileInputViewController()
        fblogin()
    }
    
    func openProfileInputViewController(){
        var targetView: ProfileInputViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProfileInput") as! ProfileInputViewController
        self.presentViewController(targetView, animated: true, completion: nil)
        /*
        let secondViewController :ProfileInputViewController = ProfileInputViewController()
        self.presentViewController(secondViewController, animated: true, completion: nil)
        */
    }
    
    func fblogin(){
        
        let permisions = ["public_profile", "user_friends", "email", "user_photos","user_about_me", "user_relationships", "user_birthday", "user_location"]
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permisions, block: {
            (user: PFUser?, error: NSError?) -> Void in
            if let facebookUser = user{
                // Your app now has publishing permissions for the user
                println("succeeded to facebook login")
                println(facebookUser)
                println(PFUser.currentUser()?.objectId)
                
                var request :FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
                request.startWithCompletionHandler({ (connection, result :AnyObject!, error :NSError!) -> Void in
                    
                    
                    println(connection)
                    
                    // TODO error handling
                    println(result)
                    println(result["id"])
                    println(result["name"])
                    println(result["birthday"])
                    var userid = result["id"] as! String
                    
                    var picurl :String = "https://graph.facebook.com/" + userid + "/picture?type=large&return_ssl_resources=1"
                    
                    
                    let url = NSURL(string: picurl)
                    let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                    
                    var uiImage = UIImage(data: data!)
                    
                    var imageData = UIImagePNGRepresentation(uiImage)
                    var parseImageFile = PFFile(name: "uploaded_image.png", data: imageData)
                    
                    
                    facebookUser["photo"] = parseImageFile
                    
                    println(picurl)
                    
                    facebookUser["username"] = result["name"]
                    facebookUser["picurl"] = picurl
                    facebookUser.save()

                })
                

                self.openProfileInputViewController()
            } else {
                println(error)
            }
        })
        
    }
}
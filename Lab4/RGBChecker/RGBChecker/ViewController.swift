//
//  ViewController.swift
//  RGBChecker
//
//  Created by Michael Tang on 10/19/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var label: UILabel!
    
    var color = ColorObject()
    let filename = "color.plist"
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        colorView.backgroundColor = UIColor(colorLiteralRed: Float(color.red!)/255, green: Float(color.green!), blue: Float(color.blue!), alpha: 1)
        label.text = "RBG(\(String(Float(color.red!))),\(String(Float(color.green!))),\(String(Float(color.blue!))))"
        
    }
    
    func docFilePath(_ filename: String) -> String?{
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        let dir = path[0] as NSString
        print(dir.appendingPathComponent(filename))
        return dir.appendingPathComponent(filename)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let filePath = docFilePath(filename) //path to data file
//        
//        //if the data file exists, use it
//        if FileManager.default.fileExists(atPath: filePath!){
//            let path = filePath
//            //load the data of the plist file into a dictionary
//            let dataDictionary = NSDictionary(contentsOfFile: path!) as! [String:String]
//            
//            if dataDictionary.keys.contains("red") {
//                color.red = Int(dataDictionary["red"]!)
//                
//            }
//            
//            if dataDictionary.keys.contains("green") {
//                color.green = Int(dataDictionary["green"]!)
//            }
//            
//            if dataDictionary.keys.contains("blue"){
//                color.blue = Int(dataDictionary["blue"]!)
//            }
//            
//            colorView.backgroundColor = UIColor(colorLiteralRed: Float(color.red!)/255, green: Float(color.green!), blue: Float(color.blue!), alpha: 1)
//        }
//        
//        //application instance
//        let app = UIApplication.shared
//        //subscribe to the UIApplicationWillResignActiveNotification notification
//        NotificationCenter.default.addObserver(self, selector: #selector(UIApplicationDelegate.applicationWillResignActive(_:)), name: NSNotification.Name(rawValue: "UIApplicationWillResignActiveNotification"), object: app)
    }

    
    func applicationWillResignActive(_ notification: Notification){
//        let filePath = docFilePath(filename)
//        let data = NSMutableDictionary()
//        //adds
//        if color.red != nil{
//            data.setValue(color.red, forKey: "red")
//            
//        }
//        if color.green != nil{
//            data.setValue(color.green, forKey: "green")
//        }
//        if color.blue != nil{
//            data.setValue(color.blue, forKey: "blue")
//        }
//        //write the contents of the array to our plist file
//        data.write(toFile: filePath!, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


//
//  ViewController.swift
//  Lab1
//
//  Created by Michael Tang on 9/8/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    let appleIcons:[String] = ["AppStore","Weather","Photos","Pages","Messages","Game Center","Newsstand"]
    let otherIcons:[String] = ["Tweetbot","Spotify","Twitter"]
    
    var appleIconIndex = 1
    var otherIconsIndex = 0
    
    @IBAction func appleIcons(_ sender: UIButton) {
        myImageView.image = UIImage(named: appleIcons[appleIconIndex])
        iconName.text = appleIcons[appleIconIndex]
        appleIconIndex += 1
        appleIconIndex %= 7
    }
    @IBAction func otherIcons(_ sender: UIButton) {
        myImageView.image = UIImage(named: otherIcons[otherIconsIndex])
        iconName.text = otherIcons[otherIconsIndex]
        otherIconsIndex += 1
        otherIconsIndex %= 3
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var iconName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set load image as appstore
        myImageView.image = UIImage(named: "AppStore")
        iconName.text = appleIcons[0]
        //Reference here for cornerRadius:https://stackoverflow.com/questions/25476139/how-do-i-make-an-uiimage-view-with-rounded-corners-cgrect-swift
        myImageView.layer.cornerRadius = 22
        myImageView.clipsToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


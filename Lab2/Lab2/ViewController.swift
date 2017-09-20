//
//  ViewController.swift
//  Lab2
//
//  Created by Michael Tang on 9/14/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var mySlider: UISlider!
    @IBOutlet weak var silderLabel: UILabel!
    
    @IBAction func changeFontSize(_ sender: UISlider) {
        let fontSize = sender.value
        silderLabel.text = String(format: "%.0f",fontSize)//String(fontSize)
        myTitleLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
    }
    @IBAction func flipSwitch(_ sender: UISwitch) {
        if sender.isOn {
            myTitleLabel.text = myTitleLabel.text?.uppercased()
        }else{
            myTitleLabel.text = myTitleLabel.text?.lowercased()
        }
    }
    @IBAction func segControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            myImage.image = UIImage(named: "cat")
            myTitleLabel.text = "Yes"
            flipSwitch(mySwitch)
        }else{
            myImage.image = UIImage(named: "grumpy")
            myTitleLabel.text = "No!"
            flipSwitch(mySwitch)
        }
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


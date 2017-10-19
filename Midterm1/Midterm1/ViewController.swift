//
//  ViewController.swift
//  Midterm1
//
//  Created by Michael Tang on 10/19/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var monthlyCommute: UISwitch!
    @IBOutlet weak var gasInTank: UISlider!
    
    @IBOutlet weak var totalCommuteTimeLabel: UILabel!
    @IBOutlet weak var gasNeededLabel: UILabel!
    @IBOutlet weak var gasInTankLabel: UILabel!
    
    @IBOutlet weak var modeImage: UIImageView!
    @IBOutlet weak var commuteButton: UIButton!
    
    var speed:Float = 20
    var isBus:Bool = false
    var isBike:Bool = false
    
    @IBAction func calculateTrip(_ sender: UIButton) {
        // s = d/t => t = d/s
        if milesTextField.text != nil {
            let distance:Float = Float(milesTextField.text!)!
            if distance > 50 {
                alertMeh(title_: "Long distance", message_: "You are traveling more than 50 miles.")
            }
            var time:Float = distance/speed
            var gas:Float = distance/24
            
            //Add ten mins for wait time for buses and no gas
            if isBus {
                time += 0.16666
                gas = 0
            }
            //No gas for bike trips
            if isBike {
                gas = 0
            }
            
            if monthlyCommute.isOn {
                time = time*20
                gas = gas*20
            }
            
            
            if Float(gasInTankLabel.text!)! < gas {
                alertMeh(title_: "No enough gas", message_: "You do not have enough gas for your commute")
            }
            
            totalCommuteTimeLabel.text = String(format:"%.2f",time*60)+" mins"
            gasNeededLabel.text = String(format:"%.2f",gas)+" gallons"
            
        }
    }
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBAction func monthSwitch(_ sender: UISwitch) {
        updateMode(segControl)
    }
    
    @IBAction func updateMode(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            modeImage.image = UIImage(named: "car_icon")
            speed = 20
            isBus = false
            isBike = false
            calculateTrip(commuteButton)
        }else if sender.selectedSegmentIndex == 2{
            modeImage.image = UIImage(named: "bike_icon")
            speed = 10
            isBus = false
            isBike = true
            calculateTrip(commuteButton)
        }else{
            modeImage.image = UIImage(named: "bus_icon")
            speed = 12
            isBus = true
            isBike = false
            calculateTrip(commuteButton)
        }
    }
    func alertMeh(title_:String,message_:String){
        let alert = UIAlertController(title: title_, message: message_, preferredStyle: UIAlertControllerStyle.alert)
        let cancel=UIAlertAction(title: "Okay", style:UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        milesTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func updateGas(_ sender: UISlider) {
        let stringValue:String = String(format: "%.0f", sender.value)
        //update label
        gasInTankLabel.text = stringValue
    }
}


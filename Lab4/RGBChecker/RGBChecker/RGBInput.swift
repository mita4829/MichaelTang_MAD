//
//  RGBInput.swift
//  RGBChecker
//
//  Created by Michael Tang on 10/19/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit

class RGBInput: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var red: UITextField!
    @IBOutlet weak var green: UITextField!
    @IBOutlet weak var blue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "color"{
            let scene1ViewController = segue.destination as! ViewController
            //check to see that text was entered in the textfields
            if red.text!.isEmpty == false{
                scene1ViewController.color.red = Int(red.text!)
            }
            if green.text!.isEmpty == false{
                scene1ViewController.color.green = Int(green.text!)
            }
            if blue.text!.isEmpty == false{
                scene1ViewController.color.blue = Int(blue.text!)
            }
        }
    }

    @IBAction func sendColor(_ sender: UIButton) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        red.resignFirstResponder()
        green.resignFirstResponder()
        blue.resignFirstResponder()
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

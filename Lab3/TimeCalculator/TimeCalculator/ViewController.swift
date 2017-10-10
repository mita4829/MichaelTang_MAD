//
//  ViewController.swift
//  TimeCalculator
//
//  Created by Michael Tang on 9/26/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var sYear: UITextField!
    @IBOutlet weak var sMonth: UITextField!
    @IBOutlet weak var sDay: UITextField!
    @IBOutlet weak var sHour: UITextField!
    @IBOutlet weak var sMin: UITextField!
    @IBOutlet weak var sSec: UITextField!

    @IBOutlet weak var eYear: UITextField!
    @IBOutlet weak var eMonth: UITextField!
    @IBOutlet weak var eDay: UITextField!
    @IBOutlet weak var eHour: UITextField!
    @IBOutlet weak var eMin: UITextField!
    @IBOutlet weak var eSec: UITextField!
    
    @IBOutlet weak var endDateLabel: UILabel!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var finalDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Reference here https://stackoverflow.com/questions/27878732/swift-how-to-dismiss-number-keyboard-after-tapping-outside-of-the-textfield
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(ViewController.endAllKeyBoard))
        self.view.addGestureRecognizer(tap)
        
        eSec.delegate = self
        eMin.delegate = self
        eHour.delegate = self
        eDay.delegate = self
        eMonth.delegate = self
        eYear.delegate = self
        
        sSec.delegate = self
        sMin.delegate = self
        sHour.delegate = self
        sDay.delegate = self
        sMonth.delegate = self
        sYear.delegate = self
   
    }

    @IBAction func calculate(_ sender: UIButton) {
        let date:Date = Date(timeIntervalSinceNow: TimeInterval(0))
        let calendar:Calendar = Calendar.current
        
        //Check for empty fields
        if(!isNotEmptyTextField()){
            return
        }
        
        let (sec,min,hour,day,month,year) = (calendar.component(.second, from: date),calendar.component(.minute, from: date),calendar.component(.hour, from: date),calendar.component(.day, from: date),calendar.component(.month, from: date),calendar.component(.year, from: date))
        
        let sSec:Int = Int(self.sSec.text!)!
        let sMin:Int = Int(self.sMin.text!)!
        let sHour:Int = Int(self.sHour.text!)!
        let sDay:Int = Int(self.sDay.text!)!
        let sMonth:Int = Int(self.sMonth.text!)!
        let sYear:Int = Int(self.sYear.text!)!
        
        //Create new date object taking difference between current and start time
        let difference:Int = (sSec-sec)+(sMin-min)*60 + (sHour-hour)*3600 + (sDay-day)*86400 + (sMonth-month)*2629746 + (sYear-year)*31556952
        
        let startDate:Date = Date(timeInterval: TimeInterval(difference), since: date)
        
        let eSec:Int = Int(self.eSec.text!)!
        let eMin:Int = Int(self.eMin.text!)!
        let eHour:Int = Int(self.eHour.text!)!
        let eDay:Int = Int(self.eDay.text!)!
        let eMonth:Int = Int(self.eMonth.text!)!
        let eYear:Int = Int(self.eYear.text!)!
        
        //let (dsec,dmin,dhour,dday,dmonth,dyear) = (calendar.component(.second, from: startDate),calendar.component(.minute, from: startDate),calendar.component(.hour, from: startDate),calendar.component(.day, from: startDate),calendar.component(.month, from: startDate),calendar.component(.year, from: startDate))
        
        let differenceEnd:Int = (eSec)+(eMin)*60+(eHour)*3600+(eDay)*86400 + (eMonth)*2629746+(eYear)*31556952

        let calculatedDate:Date = Date(timeInterval: TimeInterval(differenceEnd), since: startDate)
        
        updateEndDateView(date: calculatedDate)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func endAllKeyBoard(){
        self.view.endEditing(true)
    }
    
    func backInTimeAlert(startTime:(Int,Int,Int,Int,Int,Int), endTime:(Int,Int,Int,Int,Int,Int)) {
        if(startTime > endTime){
            let alert = UIAlertController(title: "Going in the past", message: "Unless you got the flux capacitor working and going at least 88 mph, you can't go back in time.", preferredStyle: UIAlertControllerStyle.alert)
            let cancel=UIAlertAction(title: "Okay", style:UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func isNotEmptyTextField() -> Bool {
        if (self.sSec.text?.isEmpty)! || (self.sDay.text?.isEmpty)! || (self.sMonth.text?.isEmpty)! || (self.sHour.text?.isEmpty)! || (self.sMin.text?.isEmpty)! || (self.sYear.text?.isEmpty)! || (self.eSec.text?.isEmpty)! || (self.eDay.text?.isEmpty)! || (self.eMonth.text?.isEmpty)! || (self.eHour.text?.isEmpty)! || (self.eMin.text?.isEmpty)! || (self.eYear.text?.isEmpty)! {
            let alert = UIAlertController(title: "Missing inputs", message: "Some time units where not entered", preferredStyle: UIAlertControllerStyle.alert)
            let cancel=UIAlertAction(title: "Okay", style:UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
    func updateEndDateView(date:Date){
        let calendar:Calendar = Calendar.current
        let (sec,min,hour,day,month,year) = (calendar.component(.second, from: date),calendar.component(.minute, from: date),calendar.component(.hour, from: date),calendar.component(.day, from: date),calendar.component(.month, from: date),calendar.component(.year, from: date))
        var ampm:String = "AM"
        var hourAMPM:Int = hour
        var minString:String
        var secString:String
        if hour > 12{
            hourAMPM -= 12
            ampm = "PM"
        }else if hour == 0{
            hourAMPM = 12
        }
        
        if min<10{
            minString = "0"+String(min)
        }else{
            minString = String(min)
        }
        
        if sec<10{
            secString = "0"+String(sec)
        }else{
            secString = String(sec)
        }
        
        var monthString:String
        switch month {
        case 1:
            monthString = "Jan"
            break
        case 2:
            monthString = "Feb"
            break
        case 3:
            monthString = "Mar"
            break
        case 4:
            monthString = "Apr"
            break
        case 5:
            monthString = "May"
            break
        case 6:
            monthString = "Jun"
            break
        case 7:
            monthString = "Jul"
            break
        case 8:
            monthString = "Aug"
            break
        case 9:
            monthString = "Sep"
            break
        case 10:
            monthString = "Oct"
            break
        case 11:
            monthString = "Nov"
            break
        case 12:
            monthString = "Dec"
            break
        default:
            monthString = "Undef"
        }
        
        self.endDateLabel.text = String(year)+" "+monthString+" "+String(day)+", "+String(hourAMPM)+":"+minString+":"+secString+" "+ampm
    }
}


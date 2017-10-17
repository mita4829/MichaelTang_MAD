//
//  Welcome.swift
//  BTChess
//
//  Created by Michael Tang on 10/16/17.
//  Copyright © 2017 Michael Tang. All rights reserved.
//

import UIKit

class Welcome: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Reference here https://stackoverflow.com/questions/12561735/what-are-unwind-segues-for-and-how-do-you-use-them
    @IBAction func unwindToViewControllerNameHere(segue: UIStoryboardSegue) {
        
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

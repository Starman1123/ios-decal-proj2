//
//  MainViewController.swift
//  HangmanGame
//
//  Created by Sheng Wang on 10/26/15.
//  Copyright © 2015 Sheng Wang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet var startGameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let recognizer = UITapGestureRecognizer(target: self, action: Selector("tapped:"))
        
        self.startGameLabel.userInteractionEnabled = true
        self.startGameLabel.addGestureRecognizer(recognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tapped(sender: UILabel) {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

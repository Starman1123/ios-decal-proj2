//
//  GameViewController.swift
//  HangmanGame
//
//  Created by Sheng Wang on 10/26/15.
//  Copyright © 2015 Sheng Wang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var currWordLabel: UILabel?
    @IBOutlet var newGameLabel: UILabel!
    @IBOutlet var wrongGuessesLabel: UILabel!
    
    @IBOutlet var labelA: UILabel!
    @IBOutlet var labelB: UILabel!
    @IBOutlet var labelC: UILabel!
    @IBOutlet var labelD: UILabel!
    @IBOutlet var labelE: UILabel!
    @IBOutlet var labelF: UILabel!
    @IBOutlet var labelG: UILabel!
    @IBOutlet var labelH: UILabel!
    @IBOutlet var labelI: UILabel!
    @IBOutlet var labelJ: UILabel!
    @IBOutlet var labelK: UILabel!
    @IBOutlet var labelL: UILabel!
    @IBOutlet var labelM: UILabel!
    @IBOutlet var labelN: UILabel!
    @IBOutlet var labelO: UILabel!
    @IBOutlet var labelP: UILabel!
    @IBOutlet var labelQ: UILabel!
    @IBOutlet var labelR: UILabel!
    @IBOutlet var labelS: UILabel!
    @IBOutlet var labelT: UILabel!
    @IBOutlet var labelU: UILabel!
    @IBOutlet var labelV: UILabel!
    @IBOutlet var labelW: UILabel!
    @IBOutlet var labelX: UILabel!
    @IBOutlet var labelY: UILabel!
    @IBOutlet var labelZ: UILabel!
    
    
    var labelList: [UILabel] = []
    
    let wordList: [[Character]] = [["s","a","n","d","e","r","s"],["h","a","n","g","m","a","n"], ["e","m","o","t","i","o","n"], ["p","r","o","b","l","e","m"], ["c","l","i","n","t","o","n"]]
    
    var currWordLabelList: [Character] = ["_","_","_","_","_","_","_"]
    
    var count = 1
    
    var wordNum = 1
    
    var currWordList: [Character] = ["h","a","n","g","m","a","n"]
    
    var wrongGuessesStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resetGame()
        
        let tapNew: UITapGestureRecognizer = UITapGestureRecognizer()
        tapNew.addTarget(self, action: "newGameTapped:")
        newGameLabel?.addGestureRecognizer(tapNew)
        newGameLabel?.userInteractionEnabled=true
        loadLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadLabels() {
        self.labelList = [labelA,labelB,labelC,labelD,labelE,labelF,labelG,labelH,labelI,labelJ,labelK,labelL,labelM,labelN,labelO,labelP,labelQ,labelR,labelS,labelT,labelU,labelV,labelW,labelX,labelY,labelZ]
        
        for label:UILabel in self.labelList {
            let gr = UITapGestureRecognizer(target: self, action: Selector("labelTapped:"))
            label.addGestureRecognizer(gr)
            label.userInteractionEnabled = true
        }
        
    }
    
    func labelTapped(sender :UITapGestureRecognizer) {
        
        
        let label = sender.view as! UILabel
        let str : String = label.text!.lowercaseString
        let letter: Character = str[str.startIndex.advancedBy(0)]
        
        
        if self.currWordList.contains(letter) {
            //letter entered is in the target word string
            
            var indices: [Int] = []
            var tempCount=0
            for char in self.currWordList {
                if char == letter {
                    indices.append(tempCount)
                }
                tempCount+=1
            }
            
            var newString: String = ""
            for i in 0...6 {
                if indices.contains(i) {
                    newString+=String(letter)
                    self.currWordLabelList[i]=letter
                }
                else {
                    newString+=String(self.currWordLabelList[i])
                }
            }
            self.currWordLabel?.text = newString

            
            
            //check if game is over
            if (!self.currWordLabelList.contains("_")) {
                let alertController: UIAlertController = UIAlertController(title: "Game Over", message: "You win!!!", preferredStyle: UIAlertControllerStyle.Alert)
                let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                endGame()

            }
            
        }
        else {
            self.wrongGuessesStr.append(letter)
            self.wrongGuessesStr += " "
            self.wrongGuessesLabel.text = "Wrong Guesses: " + self.wrongGuessesStr
            self.count+=1
            if self.count>=7 {
                self.imageView.image = UIImage(named: "hangman"+String(count)+".png")
                let alertController: UIAlertController = UIAlertController(title: "You lost!", message: "Play again", preferredStyle: UIAlertControllerStyle.Alert)
                let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                endGame()
            } else {
                self.imageView.image = UIImage(named: "hangman"+String(count)+".png")
            }
            
        }
        label.hidden = true
        
    }

    func resetGame() {
        self.count = 1
        let randomIndex = Int(arc4random_uniform(UInt32(wordList.count)))
        self.wordNum = randomIndex
        self.imageView.image = UIImage(named: "hangman"+String(count))
        self.currWordLabel!.text = "_______"
        self.currWordList=wordList[wordNum]
        self.currWordLabelList = ["_","_","_","_","_","_","_"]
         print("currWordList is \(self.currWordList)")
        self.wrongGuessesStr = ""
        self.wrongGuessesLabel.text = "Wrong Guesses: "
        for label:UILabel in self.labelList {
            label.hidden = false
            label.userInteractionEnabled = true
        }
    }
    
    func endGame() {
        for label:UILabel in self.labelList {
            label.userInteractionEnabled = false
        }
    }
    
    func newGameTapped(recognizer :UITapGestureRecognizer) {
        resetGame()
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

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
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var guessLabel: UILabel?
    
    @IBOutlet var newGameLabel: UILabel!
    
    let wordList: [[Character]] = [["s","a","n","d","e","r","s"],["h","a","n","g","m","a","n"], ["e","m","o","t","i","o","n"], ["p","r","o","b","l","e","m"], ["c","l","i","n","t","o","n"]]
    
    var visitedCharList: [Character] = []
    
    var currWordLabelList: [Character] = ["_","_","_","_","_","_","_"]
    
    var count = 1
    
    var wordNum = 1
    
    var currWordList: [Character] = ["h","a","n","g","m","a","n"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.currWordLabel?.text = "_______"
        let tapGuess: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGuess.addTarget(self, action: "guessLabelTapped:")
        guessLabel?.addGestureRecognizer(tapGuess)
        guessLabel?.userInteractionEnabled=true
        self.currWordList=wordList[wordNum % wordList[0].count]
        
        let tapNew: UITapGestureRecognizer = UITapGestureRecognizer()
        tapNew.addTarget(self, action: "newGameTapped:")
        newGameLabel?.addGestureRecognizer(tapNew)
        newGameLabel?.userInteractionEnabled=true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func guessLabelTapped(recognizer :UITapGestureRecognizer) {
        print("guessLabel Tapped")
        if self.textField?.text=="" {
            print("guessChar is empty string")
            let alertController: UIAlertController = UIAlertController(title: "Error", message: "Please enter your guess", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        else if self.textField?.text!.characters.count>1 {
            print("guessChar is longer than 1 char")
            let alertController: UIAlertController = UIAlertController(title: "Error", message: "Please enter only one letter", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            self.textField.text=""
        }
        else if self.textField.text<="z" && "a"<=self.textField.text {
            let letter: Character = (self.textField.text?.characters.first)!
            
            if self.visitedCharList.contains(letter) {
                let alertController: UIAlertController = UIAlertController(title: "Error", message: "You have selected this letter before!", preferredStyle: UIAlertControllerStyle.Alert)
                let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                self.textField.text=""
                return
            }
            
            if self.currWordList.contains(letter) {
                //letter entered is in the target word string
                print("guessChar is in target word string")
                var indices: [Int] = []
                var tempCount=0
                for char in self.currWordList {
                    if char == letter {
                        indices.append(tempCount)
                    }
                    tempCount+=1
                }
                
                self.visitedCharList.append(letter)
                for n in indices{
                    print(n)
                }
                
                var newString: String = ""
                count=0
                for count in 0...6 {
                    if indices.contains(count) {
                        newString+=String(letter)
                        self.currWordLabelList[count]=letter
                    }
                    else {
                        newString+=String(self.currWordLabelList[count])
                    }
                }
                self.currWordLabel?.text = newString
                self.textField.text=""
                
                
                //check if game is over
                if (!self.currWordLabelList.contains("_")) {
                    let alertController: UIAlertController = UIAlertController(title: "Game Over", message: "You win!!!", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    self.textField.text=""
                    self.textField.userInteractionEnabled = false
                    self.guessLabel?.userInteractionEnabled = false
                }
                
            }
            else {
                print("guessChar is not in target word string")
                self.count+=1
                if self.count>=7 {
                    let alertController: UIAlertController = UIAlertController(title: "You have lost!", message: "Play again", preferredStyle: UIAlertControllerStyle.Alert)
                    let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    alertController.addAction(OKAction)
                    self.presentViewController(alertController, animated: true, completion: nil)
                    self.textField.text=""
                    resetGame()
                } else {
                    print("current image is hangman"+String(count)+".gif")
                    self.imageView.image = UIImage(named: "hangman"+String(count)+".gif")
                }
                self.visitedCharList.append((self.textField.text?.characters.first)!)
                
            }
        }
        else {
            print("guessChar is not valid")
            let alertController: UIAlertController = UIAlertController(title: "Error", message: "Please enter a valid letter", preferredStyle: UIAlertControllerStyle.Alert)
            let OKAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(OKAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            self.textField.text=""
        }
        
        
    }

    func resetGame() {
        self.count = 1
        if self.wordNum==4 {
            self.wordNum = -1
        }
        self.wordNum += 1
        self.imageView.image = UIImage(named: "hangman"+String(count)+".gif")
        self.currWordLabel!.text = "_______"
        self.currWordList=wordList[wordNum % wordList[0].count]
        self.visitedCharList=[]
        self.guessLabel?.userInteractionEnabled = true
        self.textField.userInteractionEnabled = true
    }
    
    func newGameTapped(recognizer :UITapGestureRecognizer) {
        self.textField.text=""
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

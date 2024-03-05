//
//  ViewController.swift
//  WordGuessApplication
//
//  Created by Uday on 3/3/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var wordsGuessedLabel: UILabel!
    
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var WordGuess: UILabel!
    
    @IBOutlet weak var userGuessLabel: UILabel!
    
  
    @IBOutlet weak var guessLetterField: UITextField!
    
    @IBOutlet weak var guessBtn: UIButton!
    
    @IBOutlet weak var playAgainBtn: UIButton!
    
    var guess : String = ""
    var right=false
    var wordLevel : Int = 0
    var NoofWords = 0
    var remaining = 5
    var flg = false
    var ResetFlag = false
    var word = ""
    var guessed = 0
    let maxNumOfWrongGuesses = 10
    var updatedStr=""
    var count=0
    var hintword=""
    var inp=""
    var image = [["SWIFT","Programming Language", "swift"],["dog","Animal","dog"],["iphone","OS Designed in 2008","iphone"],["cycle","Two wheeler","cycle"],["macbook","Apple device","macbook"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUser(l: wordLevel)
        
        guessCountLabel.text = "You have made 0 guesses"
        statusLabel.isEnabled=false
        playAgainBtn.isHidden=true
        playAgainBtn.isEnabled=false
        
        guessBtn.isEnabled = false
        guessLetterField.addTarget(self, action: #selector(CharEntered(_:)), for: .editingChanged)

    }
    
    
    
    @IBAction func guessLetterButtonPressed(_ sender: Any) {
        playAgainBtn.isHidden=true
        playAgainBtn.isEnabled=false
        
        if(count<maxNumOfWrongGuesses && remaining>0){
        
            inp=""
            
            inp=guessLetterField.text!
            let lastIndex = inp.index(before: inp.endIndex)
            let lastCharacter = inp[lastIndex]
            //print(lastCharacter)
            
            word.append(lastCharacter)
            count=count+1
            
            updatedStr=""
            hintword=image[wordLevel][0].uppercased()
          
            //print(word,hintword.contains(word.uppercased()),hintword)
            
            //if(hintword.contains(word.uppercased())){
                for l in hintword {
                    if(word.uppercased().contains(l.uppercased())) {
                        updatedStr+="\(l.uppercased())"
                    }
                    else {
                        updatedStr+="_ "
                    }
                }
                userGuessLabel.text=updatedStr
            
            if( !hintword.contains(word.uppercased())){
                guessed=guessed+1
            }
            
           
            //check if the guessed word is matched with the word
            if userGuessLabel.text!.contains("_") == false{
                if(remaining>0 && wordLevel<5){
                    guessBtn.isEnabled=false
                    displayImage.isHidden=false
                    displayImage.image=UIImage(named: image[wordLevel][2])
                    
                    
                    guessCountLabel.text="Wow! You have made \(count) guesses to guess the word!"
                    playAgainBtn.isHidden=false
                    playAgainBtn.isEnabled=true
                    NoofWords=NoofWords+1
                    remaining=remaining-1
                    wordLevel=wordLevel+1
                    guessLetterField.text=""
                    
                    wordsGuessedLabel.text="Total number of words guessed successfully: \(NoofWords)"
                    wordsRemainingLabel.text="Total number of words remaining in game: \(remaining)"
                    totalWordsLabel.text="Total number of words in game: \(image.count)"
                    //updateUser(l:wordLevel)
                    word=""
                    count=0
                    guessed=0
                    
                    
                }
                
            }else{
                guessCountLabel.text="You have made \(count) guesses"
            }}
        
        
        else{
            guessCountLabel.text="You have used all the available guesses, Please play again"
            hintLabel.text=""
            guessLetterField.text=""
                guessBtn.isEnabled=false
                playAgainBtn.isHidden=false
                playAgainBtn.isEnabled=true
            count=0
        }
    }
    
    func GameDone(){
        statusLabel.isHidden=false
        statusLabel.text="Congratulations! You are done with the game! Please start over again"
        displayImage.isHidden=false
        displayImage.image = UIImage(named: "All")
    }
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var guessCountLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        
        if(NoofWords==5) {
            
            statusLabel.isHidden=false
            //statusLabel.isEnabled=true
            statusLabel.text="Congratulations! You are done with the game! Please start over again"
            displayImage.isHidden=false
            displayImage.image = UIImage(named: "All")
            wordLevel=0
            remaining=5
            NoofWords=0
            count=0
            word=""
            hintLabel.text=""
            guessCountLabel.text=""
            userGuessLabel.text=""
            wordsGuessedLabel.text="Total number of words guessed successfully: \(NoofWords)"
            wordsRemainingLabel.text="Total number of words remaining in game: \(remaining)"
            totalWordsLabel.text="Total number of words in game: \(image.count)"
        }else{
            updateUser(l:wordLevel)
        }
        
        
        
    }
    
    @IBOutlet weak var displayImage: UIImageView!
    
    
    func updateUser(l:Int){
        wordsGuessedLabel.text="Total number of words guessed successfully: \(NoofWords)"
        wordsRemainingLabel.text="Total number of words remaining in game: \(remaining)"
        totalWordsLabel.text="Total number of words in game: \(image.count)"
        guessCountLabel.text = "You have made 0 guesses"
        displayImage.isHidden=true
        guessLetterField.text=""
        playAgainBtn.isHidden=true
        playAgainBtn.isEnabled=true
        statusLabel.isHidden=true
        statusLabel.isEnabled=false
        
        var ans=""
        let str=image[l][0]
        for _ in str{
            ans=ans+"_"+" "
        }
        userGuessLabel.text="\(ans)"
        hintLabel.text="Hint: \(image[l][1])"
        updatedStr=""
    }
    
    
    @IBAction func CharEntered(_ sender: Any) {
        var textEnterd = guessLetterField.text!
        
        textEnterd = String(textEnterd.last ?? " ").trimmingCharacters(in: .whitespaces)
        guessLetterField.text = textEnterd
        
        if(textEnterd.isEmpty) {
            guessBtn.isEnabled = false
        }
        else {
            guessBtn.isEnabled = true
        }

    }


}


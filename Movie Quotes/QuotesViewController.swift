//
//  QuotesViewController.swift
//  Movie Quotes
//
//  Created by Mac on 12/05/1443 AH.
//

import UIKit

class QuotesViewController: UIViewController , UITextFieldDelegate  {

    var secondSelectedMovies = [Movie]()
    
    var testingTextDictionary: [String] = [ "Friends",
                                                "You",
                                                "House of GUCCI",
                                                "Greys of Anatomy",
                                                "Age of Youth",
                                                "Curella",
                                                "Spy",
                                                "Bad Moms"]
   
    @IBOutlet weak var movieNameGuessTextFeild: RVS_AutofillTextField!
    @IBOutlet weak var movieQuotesLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var correctGuessImage: UIImageView!
    
    var randomMovie: Int?
    var randomQuote: Int?
    
    var scoreCounter = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
      start()
        
    }
    
    @IBAction func correctAnswer(_ sender: UIBarButtonItem) {
        
        showAlertAction(title: "Help" , message: "Do You Want To See Correct Answer?")
       
    }
   
    @IBAction func returnKeyPressed(_ sender: Any) {
        checkAnswer()
    }
    
    func checkAnswer(){
            movieNameGuessTextFeild.isHidden = true
            movieQuotesLabel.isHidden = true
            scoreLabel.isHidden = true
            correctGuessImage.isHidden = false
            
            
            if movieNameGuessTextFeild.text == secondSelectedMovies[randomMovie!].name {
                scoreCounter+=1
                scoreLabel.text = "Score: \(scoreCounter)"
                
                correctGuessImage.image = secondSelectedMovies[randomMovie!].image

               
               delayAnswer()
                movieNameGuessTextFeild.text?.removeAll()

            }
            else {
                self.view.backgroundColor = UIColor.white
                correctGuessImage.image = UIImage(named: "wrongGuess.png")!
                delayAnswer()
                movieNameGuessTextFeild.text?.removeAll()
            }
        }
    func showAlertAction(title: String, message: String){
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "YES", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                if title == "Help"{
                    self.movieNameGuessTextFeild.isHidden = true
                    self.scoreLabel.isHidden = true
                    self.view.backgroundColor = UIColor.white
                    self.movieQuotesLabel.text = "The Answer Is .. \n\n\(self.secondSelectedMovies[self.randomMovie!].name)"
                    //self.view.backgroundColor = UIColor(named: "purplee")
                    self.delayAnswer()
                }
                else {
                    self.putQuote()
                }

            }))
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    func start(){
        movieNameGuessTextFeild?.dataSource = self
        movieNameGuessTextFeild?.delegate = self
           // let purple = UIColor(named: "purplee")
//        movieNameGuessTextFeild.layer.borderColor =  UIColor.purple.cgColor
//            movieNameGuessTextFeild.layer.borderWidth = 2
//            movieNameGuessTextFeild.layer.cornerRadius = 7
            
            correctGuessImage.isHidden = true
            putQuote()
            
        }
    func delayAnswer(){
        let seconds = 4.0
                   DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                       // Put your code which should be executed with a delay here

                       //self.view.backgroundColor =  UIColor(named: "gray")
                       self.movieNameGuessTextFeild.isHidden = false
                       self.movieQuotesLabel.isHidden = false
                       self.scoreLabel.isHidden = false
                       self.correctGuessImage.isHidden = true
                    self.view.backgroundColor = UIColor.white
                       //new random qoute
                       self.putQuote()
               }
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {

           showAlertAction(title: "Skip", message: "Do You Want To Skip This Quote?")
        }
    

    func putQuote()  {
        
        if secondSelectedMovies.isEmpty {

                   movieQuotesLabel.text = "Sorry ! select movies please... "
               }else {


                   randomMovie = Int.random(in: 0..<secondSelectedMovies.count)
                   randomQuote = Int.random(in: 0...1)

                   movieQuotesLabel.text =  secondSelectedMovies[randomMovie!].quots[randomQuote!]
                               let tap = UITapGestureRecognizer(target: self, action: #selector(QuotesViewController.tapFunction))
                               movieQuotesLabel.isUserInteractionEnabled = true
                               movieQuotesLabel.addGestureRecognizer(tap)

               }
    }

}




extension QuotesViewController: RVS_AutofillTextFieldDataSource {
    /* ################################################################## */
    /**
     This is an Array of structs, that are the searchable data collection for the text field.
     If this is empty, then no searches will return any results.
     */
    var textDictionary: [RVS_AutofillTextFieldDataSourceType] {
        var index = 0
        
        let ret: [RVS_AutofillTextFieldDataSourceType] = testingTextDictionary.compactMap {
            let currentStr = $0.trimmingCharacters(in: .whitespacesAndNewlines)
            if !currentStr.isEmpty {
                defer { index += 1 }
                return RVS_AutofillTextFieldDataSourceType(value: currentStr, refCon: index)
            }
            
            return nil
        }
        
        return ret
    }
}


extension QuotesViewController: RVS_AutofillTextFieldDelegate {
    /* ################################################################## */
    /**
     This is called when the user selects one of the autofill choices.
     In this app, all we do is print to the debug console.
     - parameter inAutofillTextField: The text field instance that the user affected.
     - parameter selectionWasMade: The data item, with the string and the refCon.
     */
    func autoFillTextField(_ inAutofillTextField: RVS_AutofillTextField, selectionWasMade inSelectedItem: RVS_AutofillTextFieldDataSourceType) {
        print("The user selected this: \(inSelectedItem.debugDescription)")
    }
}

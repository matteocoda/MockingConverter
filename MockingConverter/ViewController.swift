//
//  ViewController.swift
//  MockingConverter
//
//  Created by Matteo Coda on 20/3/20.
//  Copyright © 2020 Matteo Coda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {

    // Variables and Constants
    var inputLength = 0  /// lenght of string typed by user
    var outputLenght = 0  /// lenght of mocked string
    var output = ""  ///  final result
    
    // UI
    @IBOutlet weak var mockingText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mockingText.text = "Type here to mock someone..."
        mockingText.textColor = UIColor.lightGray

           mockingText.returnKeyType = .done
             mockingText.delegate = self
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type here to mock someone..."
        {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.resignFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Type here to mock someone..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    

    // Mocking button
    @IBAction func mock(_ sender: UIButton)
    {
        // every time the button is clicked the output is reset to nothing so that the previous output is not carried with
        output = ""
        
        // trimming, lowering and counting the input string
        let input = mockingText.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        inputLength = input!.count
        
        // while loop to change letters
        var i = 0
        while i < inputLength
        {
            // to prevent index out of bound. if i > inputLenght it means there might be a last letter at the end so look at else statement
            if i+2 <= inputLength
            {
            // getting indexes for letters that have to be capitalzied and not
            let capsIndex = input!.index((input!.startIndex), offsetBy: i)
            let lowerIndex = input!.index((input!.startIndex), offsetBy: i+1)
            // getting the letters based on the indexes above
            let capsLetter = String(input![capsIndex])
            let lowerLetter = String(input![lowerIndex])
              
                            // checking wheter one of the letters could be a blank space. if it is then just put a blank space and increase the loop by 1
                if capsLetter == " "
                            {
                                if lowerLetter == " "
                                                {
                                                    output += lowerLetter
                                                    i += 1
                                                }
                                output += capsLetter
                                i += 1
                            }
                            else
                            {
                                // no blank space so then appending one uppercased letter and one lowercased letter. increase the loop by 2
                                output += capsLetter.uppercased() + lowerLetter
                                i += 2
                            }

                
            }
            else
            {
                // checking if there's a last letter by checking if the second to last letter of what we have converted so far is lowercased. if it is then it means there is another letter after so we call back the original input and we just append the last letter at the end of our conversion and we uppercase it
                outputLenght = output.count
                            if output[output.index((output.startIndex), offsetBy: outputLenght-1)].isLowercase
                            {
                                output += input![input!.index((input!.startIndex), offsetBy: inputLength-1)].uppercased()
                                
                            }
                            else
                            {
                                // no last letter to convert so break the while loop
                                break
                            }
            }
            
        }
        
        print (output)
        mockingText.text = output
        
    }
    
}

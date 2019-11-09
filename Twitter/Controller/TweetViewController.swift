//
//  TweetViewController.swift
//  Twitter
//
//  Created by Julio Cesar Whatley on 11/8/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var countLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("Error posting twee \(Error)")
            })
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       // TODO: Check the proposed new text character count
       // Allow or disallow the new text
        
        // Set the max character limit
        let characterLimit = 140

        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)

        // TODO: Update Character Count Label

        // The new text should be allowed? True/False
        if (newText.count < characterLimit) {
            countLbl.text = String(newText.count)
            return true
        }
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

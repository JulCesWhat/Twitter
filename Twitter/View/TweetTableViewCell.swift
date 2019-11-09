//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Julio Cesar Whatley on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    var favorite: Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
             print("Error while trying to retweet tweet \(Error)")
        })
        
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, shouldFavorite: !favorite, success: {
            self.setFavorite(!self.favorite)
        }, failure: { (Error) in
            print("Error while trying to favorite or unfavorite tweet \(Error)")
        })
    }
    
    func setFavorite(_ isFavorited: Bool) {
        favorite = isFavorited
        if (favorite) {
            favBtn.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favBtn.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if (retweeted) {
            retweetBtn.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetBtn.isEnabled = false
        } else {
            retweetBtn.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetBtn.isEnabled = true
        }
    }
    
}

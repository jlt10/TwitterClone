//
//  TweetCell.m
//  twitter
//
//  Created by Jamie Tan on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTweet:(Tweet *)tweet {
    // REMEMBER TO ASK QUESTION WHY TWEET AUTOPROPERTY DIDN'T RUN WHEN "IMPORT TWEET.H" AT THE TOP OF THIS FILE
    _tweet = tweet;
    
    self.nameLabel.text = tweet.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAtLabel.text = tweet.createdAtString;
    
    self.tweetTextLabel.text = tweet.text;
    
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:tweet.user.profilePicURL];
    
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.repliesLabel.text = [NSString stringWithFormat:@"%d", tweet.replyCount];
}

@end

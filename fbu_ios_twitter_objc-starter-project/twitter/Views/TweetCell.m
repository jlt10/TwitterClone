//
//  TweetCell.m
//  twitter
//
//  Created by Jamie Tan on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
     UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImage addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImage setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)setTweet:(Tweet *)tweet {
    // REMEMBER TO ASK QUESTION WHY TWEET AUTOPROPERTY DIDN'T RUN WHEN "IMPORT TWEET.H" AT THE TOP OF THIS FILE
    _tweet = tweet;
    
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    self.retweetButton.selected = tweet.retweeted;
    
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    self.favButton.selected = tweet.favorited;
    
    self.nameLabel.text = tweet.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAtLabel.text = tweet.createdAtString;
    
    self.tweetTextLabel.text = tweet.text;
    [self.tweetTextLabel sizeToFit];
    
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:tweet.user.profilePicURL];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.repliesLabel.text = [NSString stringWithFormat:@"%d", tweet.replyCount];
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited) {
        // Procedure to unfavorite
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        // Procedure to favorite
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    if (self.tweet.retweeted) {
        // Procedure to unretweet
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else {
        // Procedure to retweet
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if (error) {
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
            } else {
                NSLog(@"Successfully retweet the following Tweet: %@", tweet.text);
            }
        }];
    }
    [self refreshData];
}


-(void) refreshData {
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.repliesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.replyCount];
    self.favButton.selected = self.tweet.favorited;
    self.retweetButton.selected = self.tweet.retweeted;
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    // TODO: Call method on delegate
    [self.delegate tweetCell:self didTap:self.tweet.user];
}
@end

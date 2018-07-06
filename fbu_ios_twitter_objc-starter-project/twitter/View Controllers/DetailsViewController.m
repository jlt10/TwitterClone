//
//  DetailsViewController.m
//  twitter
//
//  Created by Jamie Tan on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "UserProfileViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *numRetweets;
@property (weak, nonatomic) IBOutlet UILabel *numFavorites;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    self.retweetButton.selected = self.tweet.retweeted;
    
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    self.favButton.selected = self.tweet.favorited;
    
    self.nameLabel.text = self.tweet.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.dateLabel.text = self.tweet.createdAtString;
    
    self.tweetTextLabel.text = self.tweet.text;
    [self.tweetTextLabel sizeToFit];
    
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:self.tweet.user.profilePicURL];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    
    self.numRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.numFavorites.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.numRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.numFavorites.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    
    self.favButton.selected = self.tweet.favorited;
    self.retweetButton.selected = self.tweet.retweeted;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.if ([segue.identifier isEqual:@"tweetToProfile"]) {
    UserProfileViewController *profileController = [segue destinationViewController];
    profileController.user = self.tweet.user;
}

@end

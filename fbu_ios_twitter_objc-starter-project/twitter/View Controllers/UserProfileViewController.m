//
//  UserProfileViewController.m
//  twitter
//
//  Created by Jamie Tan on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "UserProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface UserProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screennameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;
@property (weak, nonatomic) IBOutlet UILabel *numTweets;
@property (weak, nonatomic) IBOutlet UIView *imageBorderView;

@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.user) {
        [[APIManager shared] getAccountDetails:^(User *user, NSError *error) {
            if (user) {
                self.user = user;
                [self refreshView];
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
        }];
    }
    [self refreshView];
}

- (void) viewDidAppear:(BOOL)animated {
    if (!self.user) {
        [[APIManager shared] getAccountDetails:^(User *user, NSError *error) {
            if (user) {
                self.user = user;
                [self refreshView];
                NSLog(@"Reloaded user");
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
        }];
    }
    // Do any additional setup after loading the view.
    [self refreshView];
}

- (void) viewDidDisappear:(BOOL)animated {
    self.user = nil;
}

- (void)refreshView {
    self.nameLabel.text = self.user.name;
    self.screennameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.tagLineLabel.text = self.user.tagLine;
    
    self.numFollowing.text = [NSString stringWithFormat:@"%d", self.user.followingCount];
    self.numFollowers.text = [NSString stringWithFormat:@"%d", self.user.followerCount];
    self.numTweets.text = [NSString stringWithFormat:@"%d", self.user.tweetCount];
    
    [self.profileImage setImageWithURL:self.user.profilePicURL];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    self.imageBorderView.layer.cornerRadius = self.imageBorderView.frame.size.height/2;

    [self.headerImage setImageWithURL:self.user.headerPicURL];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

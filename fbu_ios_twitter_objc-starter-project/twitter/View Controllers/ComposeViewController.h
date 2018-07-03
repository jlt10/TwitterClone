//
//  ComposeViewController.h
//  
//
//  Created by Jamie Tan on 7/3/18.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"


// QUESTION, WHAT IS A PROTOCOL
@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;

@end

@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end

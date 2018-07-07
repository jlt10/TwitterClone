//
//  User.h
//  twitter
//
//  Created by Jamie Tan on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *tagLine;
@property (strong, nonatomic) NSURL *profilePicURL;
@property (strong,nonatomic) NSURL *headerPicURL;
@property (strong, nonatomic) NSString *followingCount;
@property (nonatomic) int followerCount;
@property (nonatomic) int tweetCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

//
//  User.m
//  twitter
//
//  Created by Jamie Tan on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.tagLine = dictionary[@"description"];
        self.profilePicURL = [NSURL URLWithString:dictionary[@"profile_image_url_https"]];
        self.headerPicURL = [NSURL URLWithString:dictionary[@"profile_banner_url"]];
        
        self.followerCount = dictionary[@"friends_count"];
        self.followerCount = [dictionary[@"followers_count"] intValue];
        self.tweetCount = [dictionary[@"statuses_count"] intValue];
    }
    return self;
}

@end

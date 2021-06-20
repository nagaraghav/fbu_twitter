//
//  User.m
//  twitter
//
//  Created by Raghav Sreeram on 6/12/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
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
        
        self.followerCount = [dictionary[@"friends_count"] intValue]; // rag: which one to use?
        self.followerCount = [dictionary[@"followers_count"] intValue];
        self.tweetCount = [dictionary[@"statuses_count"] intValue];
    }
    return self;
}

@end

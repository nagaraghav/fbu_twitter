//
//  User.h
//  twitter
//
//  Created by Raghav Sreeram on 6/12/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSString *tagLine;
@property (strong, nonatomic) NSURL *profilePicURL;
@property (strong,nonatomic) NSURL *headerPicURL;
@property (nonatomic) int followingCount;
@property (nonatomic) int followerCount;
@property (nonatomic) int tweetCount;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

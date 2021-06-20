//
//  Tweet.m
//  twitter
//
//  Created by Raghav Sreeram on 6/12/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "Tweet.h"
#import <DateTools/NSDate+DateTools.h>


@implementation Tweet


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
     
        // Is this a re-tweet?
        NSDictionary *originalTweet = dictionary[@"retweeted_status"];
        if(originalTweet != nil){
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            
            // Change tweet to original tweet
            dictionary = originalTweet;
        }
        self.idStr = dictionary[@"id_str"];
        self.text = dictionary[@"full_text"];
        
        
        if(self.text.length > 30){
            self.text = [self.text substringToIndex:(self.text.length - 23)];
        }

        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.favorited = [dictionary[@"favorited"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        self.retweeted = [dictionary[@"retweeted"] boolValue];
        self.replyCount = [dictionary[@"reply_count"] intValue];
        
        NSDictionary * entities = dictionary[@"entities"];
        NSMutableArray * media = entities[@"media"];

        
        if(media != nil){
            self.tweetPicUrl = [NSURL URLWithString:media[0][@"media_url_https"]];
        }
        
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        

        NSString *createdAtOriginalString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // Configure the input format to parse the date string
        formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
        // Convert String to Date
        NSDate *createdAtDate = [formatter dateFromString:createdAtOriginalString];
        // Numer of seconds (positive) from today to tweet posted
        NSTimeInterval secondsBetween = [[NSDate date] timeIntervalSinceDate:createdAtDate];
        
        if (secondsBetween <= 259200) {
            self.createdAtString = createdAtDate.shortTimeAgoSinceNow;
        }
        else {
            // Configure output format
            formatter.dateStyle = NSDateFormatterShortStyle;
            formatter.timeStyle = NSDateFormatterNoStyle;
            // Convert Date to String
            self.createdAtString = [formatter stringFromDate:createdAtDate];
        }

    }
    return self;
}
+ (NSMutableArray *)tweetsWithArray:(NSArray *)dictionaries{
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dictionary in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dictionary];
        [tweets addObject:tweet];
    }
    return tweets;
}

@end

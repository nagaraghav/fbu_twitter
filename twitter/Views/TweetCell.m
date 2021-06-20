//
//  TweetCell.m
//  twitter
//
//  Created by Raghav Sreeram on 6/12/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "APIManager.h"
#import "AppDelegate.h"
#import "ProfileViewController.h"

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

    
}

-(void)setTweet:(Tweet *)tweet {
    
    _tweet = tweet;
    
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateSelected];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    self.retweetButton.selected = tweet.retweeted;
    
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateSelected];
    [self.favButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    self.favButton.selected = tweet.favorited;
    
    self.nameLabel.text = tweet.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    self.createdAtLabel.text = tweet.createdAtString;
    
    self.tweetTextLabel.text = tweet.text;
    [self.tweetTextLabel sizeToFit];
    
    self.profileImage.image = nil;
    [self.profileImage setImageWithURL:tweet.user.profilePicURL];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;


    self.tweetImageView.image = nil;
    [self.tweetImageView setImageWithURL:tweet.tweetPicUrl];
    self.tweetImageView.layer.cornerRadius = 10;
////
    
    if(tweet.tweetPicUrl != nil){
//        self.heightImageConstraint.constant = 300;
    }else{
        self.heightImageConstraint.constant = 0;
    }

    
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", tweet.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%d", tweet.favoriteCount];
    self.repliesLabel.text = [NSString stringWithFormat:@"%d", tweet.replyCount];
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    
    [self.delegate tweetCell:self didTap:self.tweet.user];
}




- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited) {

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


-(void) refreshData {
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.repliesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.replyCount];
    self.favButton.selected = self.tweet.favorited;
    self.retweetButton.selected = self.tweet.retweeted;
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





@end

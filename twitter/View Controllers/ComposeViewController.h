//
//  ComposeViewController.h
//  twitter
//
//  Created by Raghav Sreeram on 6/12/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
NS_ASSUME_NONNULL_BEGIN

@protocol ComposeViewControllerDelegate

- (void)didTweet:(Tweet *)tweet;


@end


@interface ComposeViewController : UIViewController

@property (nonatomic, strong) Tweet *replyTweet;
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end



NS_ASSUME_NONNULL_END

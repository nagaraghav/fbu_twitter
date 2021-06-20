//
//  ProfileViewController.h
//  twitter
//
//  Created by Raghav Sreeram on 6/15/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) User *user;


@end

NS_ASSUME_NONNULL_END

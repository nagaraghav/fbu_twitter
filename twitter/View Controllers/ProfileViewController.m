//
//  ProfileViewController.m
//  twitter
//
//  Created by Raghav Sreeram on 6/15/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personalBioLabel;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (!self.user) {
        [[APIManager shared] getAccountDetails:^(User *user, NSError *error) {
            if (user) {
                self.user = user;
                [self loadProfile];
            } else {
                NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
            }
        }];
    }
    [self loadProfile];
}

- (void)loadProfile {
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = [NSString stringWithFormat:@"@%@", self.user.screenName];
    self.personalBioLabel.text = self.user.tagLine;
    
    self.numFollowing.text = [NSString stringWithFormat:@"%d", self.user.followingCount];
    self.numFollowers.text = [NSString stringWithFormat:@"%d", self.user.followerCount];
    
    
    [self.profileImage setImageWithURL:self.user.profilePicURL];
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height/2;
    

    [self.bgImageView setImageWithURL:self.user.headerPicURL];

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

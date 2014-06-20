//
//  CCMatchViewController.h
//  MatchedUp
//
//  Created by Michał Kozak on 08.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCMatchViewControllerDelegate <NSObject>

-(void)presentMatchesViewController;


@end

@interface CCMatchViewController : UIViewController

@property (strong, nonatomic) UIImage *matchedUserImage;
@property (weak) id <CCMatchViewControllerDelegate> delegate;
@end

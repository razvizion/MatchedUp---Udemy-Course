//
//  CCProfileViewController.h
//  MatchedUp
//
//  Created by Michał Kozak on 05.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CCProfileViewControllerDelegate <NSObject>

-(void)didPressLike;
-(void)didPressDislike;

@end

@interface CCProfileViewController : UIViewController

@property (strong,nonatomic) PFObject *photo;
@property (weak, nonatomic) id <CCProfileViewControllerDelegate> delegate;

@end

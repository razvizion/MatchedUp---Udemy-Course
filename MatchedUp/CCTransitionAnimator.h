//
//  CCTransitionAnimator.h
//  MatchedUp
//
//  Created by Michał Kozak on 17.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCTransitionAnimator : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) BOOL presenting;

@end

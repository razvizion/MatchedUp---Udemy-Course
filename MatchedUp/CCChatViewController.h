//
//  CCChatViewController.h
//  MatchedUp
//
//  Created by Michał Kozak on 08.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "JSMessagesViewController.h"

@interface CCChatViewController : JSMessagesViewController <JSMessagesViewDataSource, JSMessagesViewDelegate>

@property (strong, nonatomic) PFObject *chatRoom;

@end

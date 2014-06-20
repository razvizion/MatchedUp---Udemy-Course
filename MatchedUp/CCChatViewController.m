//
//  CCChatViewController.m
//  MatchedUp
//
//  Created by Michał Kozak on 08.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "CCChatViewController.h"

@interface CCChatViewController ()

@property (strong, nonatomic) PFUser *withUser;
@property (strong, nonatomic) PFUser *currentUser;

@property (strong, nonatomic) NSTimer *chatTimer;

@property (nonatomic) BOOL initialLoadComplete;

@property (strong, nonatomic) NSMutableArray *chats;



@end

@implementation CCChatViewController


-(NSMutableArray *)chats{
    if(!_chats){
        _chats = [[NSMutableArray alloc]init];
        
    }
    return  _chats;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.delegate = self;
    self.dataSource = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self checkForNewChats];

    
    [[JSBubbleView appearance] setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    self.messageInputView.textView.placeHolder = @"New Message";
    [self setBackgroundColor:[UIColor whiteColor]];
    
    self.currentUser = [PFUser currentUser];
    PFUser *testUser1 = self.chatRoom[kCCChatRoomUser1Key];
    if([testUser1.objectId isEqual:self.currentUser.objectId]){
        self.withUser = self.chatRoom[kCCChatRoomUser2Key];
    }
    else{
        self.withUser = self.chatRoom[kCCChatRoomUser1Key];
    }
    self.title = self.withUser[kCCUserProfileKey][kCCUserProfileFirstNameKey];
    self.initialLoadComplete = NO;
    

    
    self.chatTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkForNewChats) userInfo:nil repeats:YES];
    
    
}
-(void)viewDidDisappear:(BOOL)animated{
    //[self.chatTimer invalidate];
  //  self.chatTimer = nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableView DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.chats count];
}


#pragma mark - TableView Delegate
-(void)didSendText:(NSString *)text{
    if(text.length != 0){
        PFObject *chat = [PFObject objectWithClassName:kCCChatClassKey];
        [chat setObject:self.chatRoom forKey:kCCChatChatRoomKey];
        [chat setObject:self.currentUser forKey:kCCChatFromUserKey];
        [chat setObject:self.withUser forKey:kCCChatToUserKey];
        [chat setObject:text forKey:kCCChatTextKey];
        [chat saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.chats addObject:chat];
            [JSMessageSoundEffect playMessageSentSound];
            [self.tableView reloadData];
            [self finishSend];
            [self scrollToBottomAnimated:YES];
        }];
    }

}
//-(void)didSendText:(NSString *)text fromSender:(NSString *)sender onDate:(NSDate *)date{
//    }

-(JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *chat = self.chats[indexPath.row];
    PFUser *testFromUser = chat[kCCChatFromUserKey];
    if([testFromUser.objectId isEqual:self.currentUser.objectId]){
        return JSBubbleMessageTypeOutgoing;
    }else{
        return JSBubbleMessageTypeIncoming;
    }
}

-(UIImageView *)bubbleImageViewWithType:(JSBubbleMessageType)type forRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *chat = self.chats[indexPath.row];
    PFUser *testFromUser = chat[kCCChatFromUserKey];

    if([testFromUser.objectId isEqual:self.currentUser.objectId]){
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleGreenColor]];
    }else{
        return [JSBubbleImageViewFactory bubbleImageViewForType:type color:[UIColor js_bubbleLightGrayColor]];

    }
}


- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyAll;
}
- (JSMessagesViewAvatarPolicy)avatarPolicy{
    return JSMessagesViewAvatarPolicyNone;
}
-(JSMessagesViewSubtitlePolicy)subtitlePolicy{
    return JSMessagesViewSubtitlePolicyNone;
}
-(JSMessageInputViewStyle)inputViewStyle{
    return JSMessageInputViewStyleFlat;
}

#pragma mark - Message View Delegate Optional

-(void)configureCell:(JSBubbleMessageCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    if([cell messageType] == JSBubbleMessageTypeOutgoing){
        cell.bubbleView.textView.textColor = [UIColor whiteColor];
    }
}
-(BOOL)shouldPreventScrollToBottomWhileUserScrolling{
    return YES;
}

#pragma mark - Messages View Data Source required

-(NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath{
    PFObject *chat = self.chats[indexPath.row];
    NSString *message = chat[kCCChatTextKey];
    return message;
}

-(NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(UIImageView *)avatarImageViewForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(NSString *)subtitleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - Helper Methods

- (void)checkForNewChats
{
    int oldChatCount = [self.chats count];
    NSLog(@"jest nowa wiadomosc");
    PFQuery *queryForChats = [PFQuery queryWithClassName:kCCChatClassKey];
    [queryForChats whereKey:kCCChatChatRoomKey equalTo:self.chatRoom];
    [queryForChats orderByAscending:@"createdAt"];
    [queryForChats findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            if (self.initialLoadComplete == NO || oldChatCount != [objects count]) {
             
                self.chats = [objects mutableCopy];
                
                [self.tableView reloadData];
                if (self.initialLoadComplete == YES){
                    [JSMessageSoundEffect playMessageReceivedSound];
                }
                self.initialLoadComplete = YES;
                [self scrollToBottomAnimated:YES];
            }
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

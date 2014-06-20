//
//  CCConstants.m
//  MatchedUp
//
//  Created by Michał Kozak on 04.04.2014.
//  Copyright (c) 2014 Raz Labs. All rights reserved.
//

#import "CCConstants.h"

@implementation CCConstants

#pragma mark - User Class


NSString *const kCCUserTagLineKey                   = @"tagLine";

NSString *const kCCUserProfileKey                   = @"profile";
NSString *const kCCUserProfileNameKey               = @"name";
NSString *const kCCUserProfileFirstNameKey          = @"firstName";
NSString *const kCCUserProfileLocationKey           = @"location";
NSString *const kCCUserProfileGenderKey             = @"gender";
NSString *const kCCUserProfileBirthdayKey           = @"birthday";
NSString *const kCCUserProfileInterestedInKey       = @"interestedIn";
NSString *const kCCUserProfilePictureURL            = @"pictureURL";
NSString *const kCCUserProfileRelationshipStatusKey = @"relationshipStatus";
NSString *const kCCUserProfileAgeKey                = @"age";

#pragma mark - Photo Class

NSString *const kCCPhotoClassKey                    = @"Photo";
NSString *const kCCPhotoUserKey                     = @"user";
NSString *const kCCPhotoPictureKey                  = @"image";


#pragma mark - Activity Class

NSString *const kCCActivityClassKey                 = @"Activity";
NSString *const kCCActivityTypeKey                  = @"type";
NSString *const kCCActivityFromUserKey              = @"fromUser";
NSString *const kCCActivityToUserKey                = @"toUser";
NSString *const kCCActivityPhotoKey                 = @"photo";
NSString *const kCCActivityTypeLikeKey              = @"like";
NSString *const kCCActivityTypeDislikeKey           = @"dislike";

#pragma mark - Settings

NSString *const kCCMenEnabledKey                    = @"men";
NSString *const kCCWomenEnabledKey                  = @"women";
NSString *const kCCSingleEnabledKey                 = @"single";
NSString *const kCCAgeMaxKey                        = @"ageMax";

#pragma mark - ChatRoom

NSString *const kCCChatRoomClassKey                 = @"ChatRoom";
NSString *const kCCChatRoomUser1Key                 = @"user1";
NSString *const kCCChatRoomUser2Key                 = @"user2";

#pragma mark - Chat

NSString *const kCCChatClassKey                     = @"Chat";
NSString *const kCCChatChatRoomKey                  = @"chatroom";
NSString *const kCCChatFromUserKey                  = @"fromUser";
NSString *const kCCChatToUserKey                    = @"toUser";
NSString *const kCCChatTextKey                      = @"text";

@end

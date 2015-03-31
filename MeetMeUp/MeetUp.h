//
//  MeetUp.h
//  MeetMeUp
//
//  Created by tim on 3/23/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MeetupDelegate <NSObject>

-(void) meetup:(NSArray *) meetupArray;

@end

@interface MeetUp : NSObject

@property id<MeetupDelegate> delegate;

@property NSString *eventName;
@property NSString *address1;
@property NSString *city;

@property (nonatomic) NSString *time;
@property NSNumber *timeSince1970;

@property NSString *eventURL;
@property NSNumber *yesRSVPCount;
@property NSString *groupName;
@property NSString *eventDescription;
@property UIImage  *image;  //change to URL later
@property NSString *groupID;

-(instancetype)initWithDictionary: (NSDictionary *)dictionary;
+(void)retrieveMeetupWithCompletion:(NSString *)searchText block:(void (^)(NSMutableArray *))complete;
-(void)getImageWithCompletion:(void (^)(NSData *))complete;

@end

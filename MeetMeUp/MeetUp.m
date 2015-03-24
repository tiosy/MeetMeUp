//
//  MeetUp.m
//  MeetMeUp
//
//  Created by tim on 3/23/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "MeetUp.h"

@implementation MeetUp

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self =[super init];
    //
    //
    return self;
}


+(NSArray *) eventArrayFromDictionary:(NSArray *)dictArray
{
    NSMutableArray *muteArray = [NSMutableArray new];

    for (NSDictionary *dict in dictArray) {
        MeetUp *meetup = [[MeetUp alloc] initWithDictionary:dict];
        [muteArray addObject:meetup];

    }

    return muteArray;
}


+(void) pullEventsFromMeetupAPI
{
    
}



@end

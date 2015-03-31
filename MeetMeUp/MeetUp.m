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

    if(self)
    {
        self.eventName = [dictionary objectForKey:@"name"];
        self.address1  = [[dictionary objectForKey:@"venue"] objectForKey:@"address_1"];
        self.city = [[dictionary objectForKey:@"venue"] objectForKey:@"city"];
        self.dateTime = [dictionary objectForKey:@"time"];
        self.eventURL = [dictionary objectForKey:@"event_url"];
        self.yesRSVPCount = [dictionary objectForKey:@"yes_rsvp_count"];
        self.groupName = [[dictionary objectForKey:@"group"] objectForKey:@"name"];
        self.groupID = [[dictionary objectForKey:@"group"] objectForKey:@"id"];
        self.eventDescription = [dictionary objectForKey:@"description"];
    }
    return self;
}

+(void)retrieveMeetupWithCompletion:(NSString *)searchText block:(void (^)(NSMutableArray *))complete
{

    NSString *string = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=95110&&text_format=plain&time=,1w&key=1ce664f564d97152966486a2c2756&text=%@", searchText];

    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        //the first is {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&connectionError];
        NSArray *results = [NSArray new];
        results = [jsonDict objectForKey:@"results"];

        NSMutableArray *meetupArray = [NSMutableArray arrayWithCapacity:results.count];
        for (NSDictionary *dict in results) {
            [meetupArray addObject:[[MeetUp alloc]initWithDictionary:dict]];
        }

        complete(meetupArray);
    }];


}




//not used...
-(void)getImageWithCompletion:(void (^)(NSData *))complete
{
    
}


@end

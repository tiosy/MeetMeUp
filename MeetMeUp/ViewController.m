//
//  ViewController.m
//  MeetMeUp
//
//  Created by tim on 3/23/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "ViewController.h"
#import "MeetUpTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property NSMutableArray *meetupArray;
@property NSMutableDictionary *meetupDictionary;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94080&text=mobile&text_format=plain&time=,1w&key=1ce664f564d97152966486a2c2756"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *connectionError) {

         self.meetupDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

         self.meetupArray = [self.meetupDictionary objectForKey:@"results"];

         [self.tableview reloadData];
     }];





}



#pragma mark - UITableViewDelegate, UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetupArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeetUpTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    NSDictionary *dictionary = [self.meetupArray objectAtIndex:indexPath.row];

    MeetUp *meetup = [self meetupGetData:dictionary];

    //cell.textLabel.text = [dictionary objectForKey:@"name"];
    //cell.detailTextLabel.text = [dictionary objectForKey:@"description"];
    //cell.detailTextLabel.numberOfLines =0; //wrapping line
    //NSURL *url = [NSURL URLWithString:[dictionary objectForKey:@"avatar_url"]];
    //cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];

    cell.labelEventName.text = meetup.eventName;
    cell.labelAddress1.text = meetup.address1;
    cell.labelCity.text = meetup.city;

    return cell;
    
}

-(MeetUp *) meetupGetData: (NSDictionary *) dic
{
    MeetUp *m = [MeetUp new];

    m.eventName = [dic objectForKey:@"name"];
    m.address1  = [[dic objectForKey:@"venue"] objectForKey:@"address_1"];
    m.city = [[dic objectForKey:@"venue"] objectForKey:@"city"];
    m.dateTimeString = [dic objectForKey:@"time"];

    return m;

                   
}






@end

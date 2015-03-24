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

@property (weak, nonatomic) IBOutlet UITextField *textField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UILabel *magnifyingGlass = [[UILabel alloc] init];
    [magnifyingGlass setText:[[NSString alloc] initWithUTF8String:"\xF0\x9F\x94\x8D"]];
    [magnifyingGlass sizeToFit];

    [self.textField setLeftView:magnifyingGlass];
    [self.textField setLeftViewMode:UITextFieldViewModeAlways];






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

    // set alternate background color based on row number (odd or even)
    if(indexPath.row % 2 == 0){
        cell.contentView.backgroundColor = [UIColor colorWithRed:255/255.0f green:247/255.0f blue:225/255.0f alpha:1.0f];
    }
    else {
        cell.contentView.backgroundColor = [UIColor clearColor];
    }




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

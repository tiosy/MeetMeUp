//
//  ViewController.m
//  MeetMeUp
//
//  Created by tim on 3/23/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "MeetUpTableViewCell.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic) NSMutableArray *meetupArray;

@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;



@end



@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.meetupArray = [NSMutableArray new];
    //each meetupArray element is a Meetup object
    //block is async
    NSString *searchText = @"";
    [MeetUp retrieveMeetupWithCompletion:searchText block:^(NSMutableArray *meetupArray) {

        self.meetupArray = meetupArray;

        //testing
        for (MeetUp *m in self.meetupArray) {NSLog(@"%@",m.eventName);}

    }];
}

//MeetuArray setter
-(void) setMeetupArray:(NSMutableArray *)meetupArray
{
    _meetupArray = meetupArray;
    [self.tableview reloadData];
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetupArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MeetUpTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    MeetUp *meetup = [self.meetupArray objectAtIndex:indexPath.row];

    cell.imageView.image = [UIImage imageNamed:@"meetup"];
    cell.textLabel.text = meetup.eventName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",meetup.time,meetup.address1];



//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[meetup.dateTime intValue]/1000.0f];
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",date,meetup.address1];

    
    //reload cell
    [cell layoutSubviews];

    // set alternate background color based on row number (odd or even)
    if(indexPath.row % 2 == 0){
        cell.contentView.backgroundColor = [UIColor colorWithRed:255/255.0f green:247/255.0f blue:225/255.0f alpha:1.0f];
    }
    else {
        cell.contentView.backgroundColor = [UIColor clearColor];
    }

    return cell;
    
}


#pragma mark - Segue to DetailVC
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVC = [segue destinationViewController];
    NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];

    MeetUp *meetup = [self.meetupArray objectAtIndex:indexPath.row];

    detailVC.meetup = meetup;
}


#pragma mark - UISearchBarDelegate Protocols
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"searchbar clicked");
    NSString *searchText = searchBar.text;

    //each meetupArray element is a Meetup object
    [MeetUp retrieveMeetupWithCompletion:searchText block:^(NSMutableArray *meetupArray) {
        self.meetupArray = meetupArray;
    }];

    [searchBar resignFirstResponder];
}

//-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    NSString *searchText = searchBar.text;
//
//    //each meetupArray element is a Meetup object
//    [MeetUp retrieveMeetupWithCompletion:searchText block:^(NSMutableArray *meetupArray) {
//        self.meetupArray = meetupArray;
//    }];
//
//    [searchBar resignFirstResponder];
//
//}

@end

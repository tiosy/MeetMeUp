//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by tim on 3/24/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "DetailViewController.h"
#import "webViewController.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelEventName;
@property (weak, nonatomic) IBOutlet UILabel *labelHostingGroup;
@property (weak, nonatomic) IBOutlet UITextView *textviewDescription;
@property (weak, nonatomic) IBOutlet UILabel *labelRSVP;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.labelEventName.text = self.meetup.eventName;
    self.labelHostingGroup.text = self.meetup.groupName;

    NSLog(@"===%@",self.meetup.yesRSVPCount);
    self.labelRSVP.text = [self.meetup.yesRSVPCount stringValue];
    self.textviewDescription.text = self.meetup.eventDescription;
    


    
}


//For button :
// 1) in storyboard drag Button to next View (webVewController)

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in wiki label tapped  %@",self.meetup.eventURL);

    webViewController *webviewVC = [segue destinationViewController];
    webviewVC.eventURL = self.meetup.eventURL;
    
}


@end

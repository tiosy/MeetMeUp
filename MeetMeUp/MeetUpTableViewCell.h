//
//  MeetUpTableViewCell.h
//  MeetMeUp
//
//  Created by tim on 3/23/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetUpTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelEventName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress1;

@property (weak, nonatomic) IBOutlet UILabel *labelCity;

@property (weak, nonatomic) IBOutlet UILabel *labelDateTime;



@end

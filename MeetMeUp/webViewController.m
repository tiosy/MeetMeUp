//
//  webViewController.m
//  MeetMeUp
//
//  Created by tim on 3/24/15.
//  Copyright (c) 2015 Timothy Yeh. All rights reserved.
//

#import "webViewController.h"

@interface webViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webview;


@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    NSURL *url = [NSURL URLWithString:self.eventURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];

}



- (IBAction)onBackButtonPressed:(id)sender {

    [self.webview goBack];
}

- (IBAction)onPreviousButtonPressed:(id)sender {
    [self.webview goForward];
}


@end

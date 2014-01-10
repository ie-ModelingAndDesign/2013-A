//
//  DetailViewController.m
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/11/28.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import "DetailViewController.h"

@implementation DetailViewController
@synthesize ti;
#pragma mark - Managing the detail item

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ti;
    
    //NSLog(@"\n%@",ti);
    NSURL *myURL = [NSURL URLWithString: [self.url stringByAddingPercentEscapesUsingEncoding:
                                          NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
    }


@end

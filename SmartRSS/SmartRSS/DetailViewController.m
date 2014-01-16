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
    NSString *decodeUrl = [self.url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodeUrl = [decodeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    encodeUrl = [encodeUrl stringByReplacingOccurrencesOfString:@"%0A%09%09" withString:@""];
    NSURL *myURL = [NSURL URLWithString:encodeUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:myURL];
    [self.webView loadRequest:request];
}

@end

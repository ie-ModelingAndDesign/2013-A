//
//  ViewController.m
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/12/11.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title = @"新規登録画面";
    [self configureView];
   
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)configureView
{
    path = [[NSBundle mainBundle] pathForResource:@"sites" ofType:@"plist"];
    plist = [NSArray arrayWithContentsOfFile:path];
    NSLog(@"\nRSS:%@\n", path);
    NSLog(@"\nRSS:%@\n", plist);
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)textFiledDoneEditing:(id)sender{
    [sender resignFirstResponder];
}
@end

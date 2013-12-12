//
//  TableViewController.m
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/12/11.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import "TableViewController.h"
#import "MasterViewController.h"

@interface TableViewController ()
@end

@implementation TableViewController

NSUInteger k;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"RSS一覧";
    [self configureView];
}

- (void)configureView
{
    path = [[NSBundle mainBundle] pathForResource:@"sites" ofType:@"plist"];
    plist = [NSArray arrayWithContentsOfFile:path];
   // NSLog(@"RSS:%@", plist);

	}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [plist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSInteger row = [indexPath row];
	cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
	cell.textLabel.text = [plist objectAtIndex:row];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"selnum"]) {
        MasterViewController *gomaster = segue.destinationViewController;
        gomaster.num = k;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    k = row;
    NSLog(@"\n選択された行は『%d行目』です！\n",k);
    
}


@end

//
//  MasterViewController.h
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/11/28.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MasterViewController : UITableViewController <NSXMLParserDelegate>{
NSString *path;
NSArray *plist;
}
@property NSInteger num;
@property NSString* sti;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

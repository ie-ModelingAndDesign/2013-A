//
//  TableViewController.h
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/12/11.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController  <NSXMLParserDelegate> {
    NSString *path;
    NSMutableArray *plist;
    NSMutableArray *dict;
    NSString * currentElement;
    NSMutableArray *rss_title;
	NSMutableString *currentTitle;
    NSXMLParser * xmlParser;
    BOOL isItem;
}
@end

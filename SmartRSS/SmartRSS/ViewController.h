//
//  ViewController.h
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/12/11.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>{
NSString *path;
NSArray *plist;
NSMutableArray *dict;
NSMutableString *str;
}
- (void)configureView;
- (void)action:(id)sender;

@end

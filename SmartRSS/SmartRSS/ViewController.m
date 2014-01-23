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
     self.title = @"RSS登録画面";
    [self configureView];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)configureView
{
    NSString *homeDir = NSHomeDirectory();
    path = [homeDir stringByAppendingPathComponent:@"Documents/sites.plist"];
   // path = [[NSBundle mainBundle] pathForResource:@"sites" ofType:@"plist"];
    plist = [NSArray arrayWithContentsOfFile:path];
   // NSLog(@"\nRSS:%@\n", path);
    
    UITextField *customTextField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 100.0, 300.0, 40.0)];
	customTextField.borderStyle = UITextBorderStyleRoundedRect;
	customTextField.font = [UIFont systemFontOfSize:20.0];
	customTextField.textColor = [UIColor blackColor];
    customTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	customTextField.backgroundColor = [UIColor whiteColor];
	customTextField.placeholder = @"ここに入力してください";
	customTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	customTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	customTextField.keyboardType = UIKeyboardTypeEmailAddress; 
	customTextField.returnKeyType = UIReturnKeyDone;
	customTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	customTextField.delegate = self;
	[customTextField addTarget:self action:@selector(action:) forControlEvents:UIControlEventEditingDidEnd];
    [customTextField becomeFirstResponder];
	[self.view addSubview:customTextField];
}

/*
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
- (void)action:(id)sender
{
    tempTextField = sender;
  //  NSLog(@"入力された文字は『%@』です！",tempTextField.text);
   // str = [NSMutableString stringWithFormat:@"%@", tempTextField.text];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return YES;
}



- (IBAction)button:(id)sender {
   // NSLog(@"\n%@\n", str);
    str = [NSMutableString stringWithFormat:@"%@", tempTextField.text];

    dict = [NSMutableArray arrayWithContentsOfFile:path];
   
    [dict addObject:str];
    
    BOOL result = [dict writeToFile:path atomically:NO];
    if (!result) {
        NSLog(@"ファイルの書き込みに失敗");
    }else{
        NSLog(@"ファイルの書き込みが完了しました");
        tempTextField.text=NULL;

        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"登録完了しました！"
                              message:@"新規RSSの登録出来ました！"
                              delegate:self
                              cancelButtonTitle:@"OK！" otherButtonTitles:nil];
        [alert show];
        
    }
    NSArray *allControllers = self.navigationController.viewControllers;
    NSInteger target = [allControllers count] - 2;
    UITableViewController *parent = [allControllers objectAtIndex:target];
    [parent.tableView reloadData];
}

@end

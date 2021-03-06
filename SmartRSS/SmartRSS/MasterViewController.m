//
//  MasterViewController.m
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/11/28.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Reachability.h"

@interface MasterViewController () {
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSString *element;

}
@end

@implementation MasterViewController

@synthesize num;
@synthesize sti;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // sti=@"記事一覧";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *s = [ud stringForKey:@"sti"];
    if (s == nil && [s length] == 0) {
        s=@"News-ie";
    }
    self.title = s;
    NSString *homeDir = NSHomeDirectory();
    path = [homeDir stringByAppendingPathComponent:@"Documents/sites.plist"];
    // path = [[NSBundle mainBundle] pathForResource:@"sites" ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // ファイルが存在するか?
    if ([fileManager fileExistsAtPath:path]) {
        NSLog(@"%@は既に存在しています", path);
    } else {
        NSLog(@"%@は存在していません", path);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *directory = [paths objectAtIndex:0];
        NSString *filePath = [directory stringByAppendingPathComponent:@"sites.plist"];
        
        NSArray *array = @[@"http://ie.u-ryukyu.ac.jp/news-ie/feed/",@"http://alfalfalfa.com/index.rdf",
                           @"http://news.2chblog.jp/index.rdf"];
        BOOL successful = [array writeToFile:filePath atomically:NO];
        if (successful) {
            NSLog(@"%@", @"データの保存に成功しました。");
        }
        

        }
   
    Reachability* curReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus == NotReachable) {
        [self erroralert];
            } else {
        NSLog(@"ネットワーク接続あり");
    }
    
    
    plist = [NSArray arrayWithContentsOfFile:path];
    
   // NSLog(@"%d", num);
    
   // NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    long i = [ud integerForKey:@"num"];
    
    feeds = [[NSMutableArray alloc] init];
    NSURL *url = [NSURL URLWithString: plist[i]];
    parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item    = [[NSMutableDictionary alloc] init];
        title   = [[NSMutableString alloc] init];
        link    = [[NSMutableString alloc] init];
       
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:link forKey:@"link"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    } else if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
 
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self reloadData];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSString *string = [feeds[indexPath.row] objectForKey: @"link"];
        [[segue destinationViewController] setUrl:string];
        
        NSString *st = [feeds[indexPath.row] objectForKey: @"title"];
        DetailViewController *gomaster = segue.destinationViewController;
        gomaster.ti = st;
        
    }
 
}

-(void)reloadData{
    [self.tableView reloadData];

}

-(IBAction)refresh:(id)sender {
    
    Reachability* curReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    if (netStatus == NotReachable) {
    
        [self erroralert];
   
    } else {
    [self viewDidLoad];
    [self.tableView reloadData];
    [UIView animateWithDuration:1.0f
        animations:^{
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                    withRowAnimation:UITableViewRowAnimationBottom];
            }];
    [self top];
    }

}

-(void)top{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:
     UITableViewScrollPositionTop animated:YES];
}

-(void)erroralert{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"ネットワークエラー"
                          message:@"ネットワークに接続されていません。\n記事が取得出来ません。"
                          delegate:self
                          cancelButtonTitle:@"OK！" otherButtonTitles:nil];
    [alert show];

}

@end

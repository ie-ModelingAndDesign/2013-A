//
//  TableViewController.m
//  SmartRSS
//
//  Created by Natsuki KOBAYASHI on 2013/12/11.
//  Copyright (c) 2013年 Natsuki KOBAYASHI. All rights reserved.
//

#import "TableViewController.h"
#import "MasterViewController.h"

@interface TableViewController (){
    NSXMLParser *parser;
    NSMutableArray *feeds;
    NSMutableDictionary *item;
    NSMutableString *title;
    NSMutableString *link;
    NSString *element;
}

@end
@implementation TableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"RSS一覧";
    [self configureView];
}

- (void)configureView
{
    
    NSString *homeDir = NSHomeDirectory();
    
    path = [homeDir stringByAppendingPathComponent:@"Documents/sites.plist"];

    //path = [[NSBundle mainBundle] pathForResource:@"sites" ofType:@"plist"];
    plist = [NSMutableArray arrayWithContentsOfFile:path];
   
  //  NSLog(@"RSS:%@", path);

	}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    
    }
    return self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

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
    [self configureView];
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    // Configure the cell...
    NSInteger row = [indexPath row];
    
    NSURL *xmlURL = [NSURL URLWithString:[plist objectAtIndex:row]];
    xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
	cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
	cell.textLabel.text = currentTitle;
    //cell.textLabel.text = [plist objectAtIndex:row];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
     NSLog(@"%@",plist);
    NSInteger row = [indexPath row];
    [plist removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]
     withRowAnimation:UITableViewRowAnimationFade];
  
    }
  
    NSInteger row = [indexPath row];
    
    dict = [NSMutableArray arrayWithContentsOfFile:path];
    
    
    [dict removeObjectAtIndex:row];
  //  NSLog(@"%@", dict);
    
    BOOL result = [dict writeToFile:path atomically:NO];
    if (!result) {
     NSLog(@"ファイルの書き込みに失敗");
    }else{
     NSLog(@"ファイルの書き込みが完了しました");
 }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:[indexPath row] forKey:@"num"];
   
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict{
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"channel"]) {
		currentTitle = [[NSMutableString alloc] init];
	}
    if ([elementName isEqualToString:@"item"]) {
        isItem = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (!isItem) {
        if ([currentElement isEqualToString:@"title"]) {
            [currentTitle setString:string];
            [xmlParser abortParsing];
        }
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    if (!isItem) {
        if ([elementName isEqualToString:@"channel"]) {
            NSLog(@"adding story: %@", currentTitle);
        }
	}
    isItem = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    // 強制的にメニューの項目をすべて再表示させる。
    // これをしないと、子メニューで選択された項目の内容が表示に反映されない。
    [self.tableView reloadData];
    
    [super viewDidAppear:animated];
}

/*
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"error: %@", parseError);
    
}
 */

/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"selnum"]) {
        MasterViewController *gomaster = segue.destinationViewController;
        gomaster.num = k;

    }
 
}*/

@end

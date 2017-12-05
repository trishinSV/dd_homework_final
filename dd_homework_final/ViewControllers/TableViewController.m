//
//  TableViewController.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "TableViewController.h"
#import "CollectionViewController.h"
#import "TagsSupport.h"
@interface TableViewController ()<TagsSupportDelegate> {
    NSString *selectedTag;
    TagsSupport *support;
}

@property(nonatomic,strong) NSArray * tags;
@property(nonatomic,strong) NSArray * photos;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.navigationItem.title = @"TOP10 TAGS  IN 1 DAY";
    support = [[TagsSupport alloc] init];
    support.delegate = self;
    
    
    self.tableView.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView.refreshControl addTarget:self
                                      action:@selector(updateTags)
                            forControlEvents:UIControlEventValueChanged];
    [self.tableView.refreshControl beginRefreshing];
    
    [self updateTags];
}
- (void)updateTags {
    [support getTags];
}

- (void)setReceivedTags:(NSArray *)tags {
    
    self.tags = tags;
    [self.tableView reloadData];
    [self.tableView.refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Top tags" forIndexPath:indexPath];
    cell.textLabel.text = [[self.tags objectAtIndex:indexPath.row] valueForKeyPath:@"_content"];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    selectedTag = cell.textLabel.text;
    
    [self performSegueWithIdentifier:@"ShowCollection" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"ShowCollection"]) {
        CollectionViewController *dvc = (CollectionViewController *)segue.destinationViewController;
        dvc.currentTag = selectedTag;
    }
}
@end

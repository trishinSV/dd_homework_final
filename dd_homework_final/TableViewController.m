//
//  TableViewController.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    FlikrGetter * temp = [[FlikrGetter alloc]init];
    self.tags = [temp getListOfTopTags];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Top tags" forIndexPath:indexPath];
    cell.textLabel.text = [[self.tags objectAtIndex:indexPath.row] valueForKeyPath:@"_content"];
    // Configure the cell...
    
    return cell;
}



@end

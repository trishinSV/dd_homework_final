//
//  TableViewController.h
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlikrGetter.h"


@interface TableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong) NSArray * tags;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
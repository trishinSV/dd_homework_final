//
//  SearchViewController.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 27.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "SearchViewController.h"
#import "CollectionViewController.h"
@interface SearchViewController ()
@property (strong, nonatomic) IBOutlet UISearchBar *searchResult;
@property(nonatomic,strong) NSString * tag;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchResult.delegate = self;
    self.navigationItem.title = @"Search";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self.searchResult resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    self.tag = self.searchResult.text;
    [self performSegueWithIdentifier:@"showBySearch" sender:self];
    
}

 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqual:@"showBySearch"]) {
         CollectionViewController *dvc = (CollectionViewController *)segue.destinationViewController;
         dvc.currentTag = self.searchResult.text;
     }
 }

@end

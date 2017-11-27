//
//  CollectionViewController.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "CollectionViewController.h"
#import "ImageViewController.h"
#import "TagsWithPhotos.h"
#import "PhotoSize.h"
@interface CollectionViewController () <TagPhotosDelegate> {
    TagsWithPhotos *support;
    
    NSDictionary *currentImageSizes;
}

@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;


@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    
    self.navigationItem.title = self.currentTag;
    
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.indicator.center = CGPointMake(self.collectionView.frame.size.width / 2, self.collectionView.frame.size.height / 2);
    [self.indicator startAnimating];
    [self.collectionView addSubview:self.indicator];
    
    self.photos = [[NSMutableArray alloc] init];
    
    support = [[TagsWithPhotos alloc] initWithTag:self.currentTag];
    support.delegate = self;
    [support loadTagPhotos:self.currentTag];
}

- (void)addPhotoImage:(PhotoSize *)photoImage {
    [self.photos addObject:photoImage];
    [self.collectionView reloadData];
}

- (void)updateNumberOfPhotos {
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
    
    [self.collectionView reloadData];
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return support.nubmerOfPhotos;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    if (indexPath.row < self.photos.count) {
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        PhotoSize *photoImage = self.photos[indexPath.row];
        imgView.image = photoImage.image;
        [cell addSubview:imgView];
    } else {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicator startAnimating];
        indicator.center = CGPointMake(cell.frame.size.width / 2, cell.frame.size.height / 2);
        [cell addSubview:indicator];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.photos.count) {
        return YES;
    } else {
        return NO;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoSize *photoImage = self.photos[indexPath.row];
    currentImageSizes = photoImage.sizes;
    [self performSegueWithIdentifier:@"ShowPhoto" sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"ShowPhoto"]) {
        ImageViewController *dvc = (ImageViewController *)segue.destinationViewController;
        dvc.sizes = currentImageSizes;
    }
}
@end

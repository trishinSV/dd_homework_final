//
//  ImageViewController.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "ImageViewController.h"
#import "PhotoSupport.h"
#import "PhotoSize.h"

@interface ImageViewController ()<ImageDelegate, UIScrollViewDelegate> {
    PhotoSupport *support;
}

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.scrollView.delegate = self;
    
    self.photoImageView.frame = self.scrollView.bounds;
    [self.photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    self.scrollView.contentSize = CGSizeMake(self.photoImageView.frame.size.width, self.photoImageView.frame.size.height);
    self.scrollView.maximumZoomScale = 4.0;
   self. scrollView.minimumZoomScale = 1.0;
    self.scrollView.delegate = self;
    
    
    
    support = [[PhotoSupport alloc] init];
    support.delegate = self;
    [support loadPhotoWithSize:[self chooseSize] photoSizes:self.sizes delegate:self];
    
    self.scrollView.contentSize = self.photoImageView.image.size;
    self.photoImageView.frame = CGRectMake(0, 0, self.photoImageView.image.size.width, self.photoImageView.image.size.height);
    [self.indicator startAnimating];
}

- (NSString *)chooseSize {
    if ([self.sizes objectForKey:LARGE_SIZE]) {
        return LARGE_SIZE;
    } else {
        return MEDIUM_SIZE;
    }
}

- (void)setLoadedPhoto:(PhotoSize *)photoImage {
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
    self.photoImageView.image = photoImage.image;
}

@end

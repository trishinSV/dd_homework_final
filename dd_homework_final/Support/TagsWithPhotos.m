//
//  TagsWithPhotos.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "TagsWithPhotos.h"
#import "FlickrInteraction.h"

@interface TagsWithPhotos () <FlickrInteractionWithPhotosByTagDelegate>

@property (nonatomic, copy) NSString *tag;


@end

@implementation TagsWithPhotos

- (id)initWithTag:(NSString *)tag {
    self = [super init];
    if (self) {
        _tag = tag;
        _nubmerOfPhotos = 0;
    }
    return self;
}

- (void)loadTagPhotos:(NSString *)tag {
    [FlickrInteraction getPhotosIDByTag:self.tag delegate:self];
}


- (void)setPhotosID:(NSArray *)photosID {
    self.nubmerOfPhotos = photosID.count;
    [self.delegate updateNumberOfPhotos];
    [FlickrInteraction getSizeOfPhotosWithID:photosID delegate:self];
}

- (void)addLoadedPhoto:(PhotoSize *)image {
    [self.delegate addPhotoImage:image];
}

@end

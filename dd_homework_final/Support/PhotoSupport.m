//
//  PhotoSupport.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "PhotoSupport.h"
#import "FlickrInteraction.h"

@interface PhotoSupport () <FlickrInteractionWithPhotosByTagDelegate>

@end

@implementation PhotoSupport

- (void)loadPhotoWithSize:(NSString *)size photoSizes:(NSDictionary *)photoSizes delegate:(id)delegate {
    [FlickrInteraction getPhotoWithSize:size photoSizes:photoSizes session:nil delegate:self];
}

- (void)addLoadedPhoto:(PhotoSize *)image {
    [self.delegate setLoadedPhoto:image];
}



@end

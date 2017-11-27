//
//  FlickrInteraction.h
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoSize.h"

#define FlickrAPIKey @"456d4ff9dfa28a11606a580505b4fa72"


@protocol FlickrInteractionTagsDelegate
- (void)setReceivedTags:(NSArray *)tags;
@end


@protocol FlickrInteractionWithPhotosByTagDelegate
- (void)addLoadedPhoto:(PhotoSize *)image;
@optional
- (void)setPhotosID:(NSArray *)photosID;
@end

@interface FlickrInteraction : NSObject
+ (NSURL *)URLforTopTags;

+ (void)getListOfTopTags:(id <FlickrInteractionTagsDelegate>)delegate;
+ (void)getPhotosIDByTag:(NSString *)tag delegate:(id <FlickrInteractionWithPhotosByTagDelegate>)delegate;
+ (void)getSizeOfPhotosWithID:(NSArray *)photoIDs delegate:(id <FlickrInteractionWithPhotosByTagDelegate>)delegate;
+ (void)getPhotoWithSize:(NSString *)size photoSizes:(NSDictionary *)photoSizesURL session:(NSURLSession *)session delegate:(id <FlickrInteractionWithPhotosByTagDelegate>)delegate;


@property(strong,nonatomic) NSArray * tags; // массив словарей NSDictionary с Flickr tags
@property(strong,nonatomic) NSArray * photos; // массив словарей NSDictionary с Flickr photo
@end











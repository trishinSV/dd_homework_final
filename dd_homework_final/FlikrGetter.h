//
//  FlikrGetter.h
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import <Foundation/Foundation.h>


#define FlickrAPIKey @"456d4ff9dfa28a11606a580505b4fa72"


@interface FlikrGetter : NSObject
+ (NSURL *)URLforTopTags;
-(NSArray *)getListOfTopTags;
-(NSArray *)getListOfPhotos;

@property(strong,nonatomic) NSArray * tags; // массив словарей NSDictionary с Flickr tags
@property(strong,nonatomic) NSArray * photos; // массив словарей NSDictionary с Flickr photo
@end











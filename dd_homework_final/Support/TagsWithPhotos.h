//
//  TagsWithPhotos.h
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PhotoSize.h"

@protocol TagPhotosDelegate <NSObject>
- (void)addPhotoImage:(PhotoSize *)photoImage;
- (void)updateNumberOfPhotos;
@end

@interface TagsWithPhotos : NSObject

- (id)initWithTag:(NSString *)tag;

@property (nonatomic, assign) NSInteger nubmerOfPhotos;
@property (nonatomic, weak) id <TagPhotosDelegate> delegate;
- (void)loadTagPhotos:(NSString *)tag;

@end

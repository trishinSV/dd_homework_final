//
//  PhotoSupport.h
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PhotoSize;

@protocol ImageDelegate <NSObject>
- (void)setLoadedPhoto:(PhotoSize *)photoImage;
@end

@interface PhotoSupport : NSObject

@property (nonatomic, weak) id <ImageDelegate> delegate;

- (void)loadPhotoWithSize:(NSString *)size photoSizes:(NSDictionary *)photoSizes delegate:(id)delegate;

@end


//
//  PhotoSize.h
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LARGE_SIZE @"Large"
#define MEDIUM_SIZE @"Medium"
#define LARGE_SQUARE_SIZE @"Large Square"


@interface PhotoSize : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSDictionary *sizes;

- (id)initWithImage:(UIImage *)image photoSizes:(NSDictionary *)sizes;

@end

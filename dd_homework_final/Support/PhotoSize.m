//
//  PhotoSize.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "PhotoSize.h"

@implementation PhotoSize

- (id)initWithImage:(UIImage *)image photoSizes:(NSDictionary *)sizes {
    self = [super init];
    if (self) {
        _image = image;
        _sizes = sizes;
    }
    return self;
}
@end

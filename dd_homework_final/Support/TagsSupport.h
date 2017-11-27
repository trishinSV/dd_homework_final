//
//  TagsSupport.h
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol TagsSupportDelegate <NSObject>
- (void)setReceivedTags:(NSArray *)tags;
@end

@interface TagsSupport : NSObject

@property (nonatomic, weak) id <TagsSupportDelegate> delegate;

- (void)getTags;

@end

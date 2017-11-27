//
//  TagsSupport.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 26.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//


#import "TagsSupport.h"
#import "FlickrInteraction.h"

@interface TagsSupport () <FlickrInteractionTagsDelegate>
@end

@implementation TagsSupport

- (void)getTags {
    [FlickrInteraction getListOfTopTags:self];
}

- (void)setReceivedTags:(NSArray *)tags {
    [self.delegate setReceivedTags:tags];
}



@end

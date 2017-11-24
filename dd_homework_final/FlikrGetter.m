//
//  FlikrGetter.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "FlikrGetter.h"

@implementation FlikrGetter
+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@", query, FlickrAPIKey];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforTopTags

{
    return [self URLForQuery:@"https://api.flickr.com/services/rest/?method=flickr.tags.getHotList&period=day&count=10"];
}




+ (NSURL *)URLforPhotosInPlace:(id)tag;
{
    return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&tags=%@",tag]];
}




-(NSArray *) getListOfTopTags{
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group); // добавляем в группу задачу

    NSArray * __block topTags;
    NSURL * url = [FlikrGetter URLforTopTags];
    NSLog(@"URL %@",url);
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:url
                                                 completionHandler:
                                       ^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                           if (!error) {
                                               NSData * jsonResults = [NSData dataWithContentsOfURL:url];
                                               NSDictionary * results = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
                                           // NSLog(@"%@",results);
                    
                                               NSArray *tagsTemp = [results valueForKeyPath:@"hottags.tag"];
                                               topTags = tagsTemp;
                                                dispatch_group_leave(group);
                                           }
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               NSLog(@"%@", topTags);
                                               self.tags= topTags;
                                           });
                                        
                                       }];
    
    [task resume];
     dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    self.tags = topTags;
    return topTags;
}



-(void)setPhotos:(NSArray *)photos
{

    _photos =photos;

}

-(NSArray *)getListOfPhotos{

    NSURL *url = [FlikrGetter URLforPhotosInPlace: [self.tags valueForKeyPath:@"_content"]] ;
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url
                                                completionHandler:
                                      ^(NSURL *location, NSURLResponse *response, NSError *error) {
                                          if (!error) {
                                              NSData *jsonResults = [NSData dataWithContentsOfURL:url];
                                              NSDictionary *results = [NSJSONSerialization JSONObjectWithData:jsonResults
                                                                                                      options:0
                                                                                                        error:NULL];
                                              NSArray *photos =[results valueForKeyPath:FLICKR_RESULTS_PHOTOS];
                                              self.photos =photos;
                                          }
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              [self.refreshControl endRefreshing]; // останавливаем refresh control
                                              
                                          });
                                      }];
    [task resume];
}


@end

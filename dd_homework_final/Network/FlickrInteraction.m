//
//  FlickrInteraction.m
//  dd_homework_final
//
//  Created by Сергей Тришин on 24.11.2017.
//  Copyright © 2017 Сергей Тришин. All rights reserved.
//

#import "FlickrInteraction.h"

@implementation FlickrInteraction
+ (NSURL *)URLForQuery:(NSString *)query
{
    query = [NSString stringWithFormat:@"%@&format=json&nojsoncallback=1&api_key=%@", query, FlickrAPIKey];
    query = [query stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [NSURL URLWithString:query];
}

+ (NSURL *)URLforTopTags{
    return [self URLForQuery:@"https://api.flickr.com/services/rest/?method=flickr.tags.getHotList&period=day&count=10"];
}

+ (NSURL *)URLforPhotosByTag:(id)tag{
    return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&tags=%@&per_page=10",tag]];
}

+ (NSURL *)getInfoByID:(id)ID{
    return [self URLForQuery:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getSizes&photo_id=%@",ID]];
}




+(void) getListOfTopTags:(id <FlickrInteractionTagsDelegate>)delegate{
    NSArray * __block topTags;
    NSURL * url = [FlickrInteraction URLforTopTags];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:url
                                                 completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                           if (!error) {
                                               NSData * jsonResults = [NSData dataWithContentsOfURL:url];
                                               NSDictionary * results = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
                                               topTags = [results valueForKeyPath:@"hottags.tag"];
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   [delegate setReceivedTags:topTags];
                                               });
                                           }
                                       }];
    [task resume];
}


+ (void)getPhotosIDByTag:(NSString *)tag delegate:(id <FlickrInteractionWithPhotosByTagDelegate>)delegate {
    NSURL * requestUrl = [FlickrInteraction URLforPhotosByTag: tag];
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask * task = [session downloadTaskWithURL:requestUrl
                                                 completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                     if (!error) {
                                                         NSData * jsonResults = [NSData dataWithContentsOfURL:requestUrl];
                                                         NSDictionary * results = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
                                                          NSArray *loadedPhotoIDs = [results valueForKeyPath:@"photos.photo"];
                                                         NSMutableArray *photoIDs = [[NSMutableArray alloc] init];
                                                         for (NSDictionary *dic in loadedPhotoIDs) {
                                                             [photoIDs addObject:[dic objectForKey:@"id"]];
                                                         }
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             [delegate setPhotosID:photoIDs];
                                                         });
                                                     }
                                                 }];
     [task resume];
}

+ (void)getSizeOfPhotosWithID:(NSArray *)photoIDs delegate:(id <FlickrInteractionWithPhotosByTagDelegate>)delegate {
    NSURLSession * session = [NSURLSession sharedSession];
    for (NSString *pID in photoIDs) {
        NSURL *requestUrl = [FlickrInteraction getInfoByID:pID];
        NSURLSessionDownloadTask * task = [session downloadTaskWithURL:requestUrl
                                                     completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         if (!error) {
                                                             NSData * jsonResults = [NSData dataWithContentsOfURL:requestUrl];
                                                             NSDictionary * results = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
                                                             NSArray *loadedPhotoSizesURL = [results valueForKeyPath:@"sizes.size"];
                                                             NSMutableDictionary *requredPhotoSizesURL = [[NSMutableDictionary alloc] init];
                                                             for (NSDictionary *dic in loadedPhotoSizesURL) {
                                                                 NSString *photoSize = [dic objectForKey:@"label"];
                                                                 if ([photoSize isEqual:LARGE_SQUARE_SIZE] || [photoSize isEqual:MEDIUM_SIZE] || [photoSize isEqual:LARGE_SIZE]) {
                                                                     NSString *photoURLstring = [[dic objectForKey:@"source"] stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                                                                     [requredPhotoSizesURL setValue:[NSURL URLWithString:photoURLstring] forKey:photoSize];
                                                                 }
                                                             }
                                                             dispatch_async(dispatch_get_main_queue(), ^{
                                                                 [FlickrInteraction getPhotoWithSize:LARGE_SQUARE_SIZE photoSizes:requredPhotoSizesURL session:session delegate:delegate];
                                                             });
                                                         }
                                                     }];
  [task resume];
    }
}

+ (void)getPhotoWithSize:(NSString *)size photoSizes:(NSDictionary *)photoSizesURL session:(NSURLSession *)session delegate:(id <FlickrInteractionWithPhotosByTagDelegate>)delegate {
    NSString *urlString = [NSString stringWithFormat:@"%@", [photoSizesURL objectForKey:size]];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    
    
    if (!session) {
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    
    [[session downloadTaskWithURL:requestURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            PhotoSize *img = [[PhotoSize alloc] initWithImage:[UIImage imageWithData: [NSData dataWithContentsOfURL:location]] photoSizes:photoSizesURL];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [delegate addLoadedPhoto:img];
            });
        }
    }] resume];
}
@end

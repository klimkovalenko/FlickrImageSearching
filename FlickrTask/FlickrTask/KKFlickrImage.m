//
//  KKFlickrImage.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/16/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKFlickrImage.h"
#import "KKDataManager.h"

@implementation KKFlickrImage

+ (NSArray *)imageParserWithResponseObject:(NSArray *)array
{
    NSMutableArray *tempArray = [NSMutableArray new];
    
    for (NSDictionary *dict in array) {
        
        KKFlickrImage *flickrImage = [[KKFlickrImage alloc] init];
        
        flickrImage.farmID = [dict valueForKey:@"farmID"];
        flickrImage.imageID = [dict valueForKey:@"imageID"];
        flickrImage.isFamily = [dict valueForKey:@"isFamily"];
        flickrImage.isFriend = [dict valueForKey:@"isFriend"];
        flickrImage.isPublic = [dict valueForKey:@"isPublic"];
        flickrImage.owner = [dict valueForKey:@"owner"];
        flickrImage.secret = [dict valueForKey:@"secret"];
        flickrImage.serverID = [dict valueForKey:@"serverID"];
        flickrImage.imageTitle = [dict valueForKey:@"imageTitle"];
        
        NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",
                               flickrImage.farmID,
                               flickrImage.serverID,
                               flickrImage.imageID,
                               flickrImage.secret];
        
        flickrImage.imageURLString = urlString;
        [[KKDataManager sharedManager] addNewFlickrImageWithTempFlickImage:flickrImage];
        
        [tempArray addObject:flickrImage.imageID];
    }
    
    NSArray *arrayOfMatchesImages = [[KKDataManager sharedManager]
                                    arrayOfMathesImagesWithArrayOfTempImagesID:[tempArray copy]];
    
    return arrayOfMatchesImages;
}

@end

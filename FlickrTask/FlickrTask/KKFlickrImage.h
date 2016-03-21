//
//  KKFlickrImage.h
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/16/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKFlickrImage : NSObject

@property (strong, nonatomic) NSString *imageURLString;

@property (strong, nonatomic) NSNumber *farmID;
@property (strong, nonatomic) NSString *imageID;
@property (strong, nonatomic) NSNumber *isFamily;
@property (strong, nonatomic) NSNumber *isFriend;
@property (strong, nonatomic) NSNumber *isPublic;
@property (strong, nonatomic) NSString *owner;
@property (strong, nonatomic) NSString *secret;
@property (strong, nonatomic) NSString *serverID;
@property (strong, nonatomic) NSString *imageTitle;

+ (NSArray *)imageParserWithResponseObject:(NSArray *)array;

@end

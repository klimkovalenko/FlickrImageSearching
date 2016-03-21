//
//  KKFlickrImageEntity.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/17/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKFlickrImageEntity.h"

@implementation KKFlickrImageEntity

+ (FEMMapping *)defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithEntityName:@"KKFlickrImageEntity"];
    
    [mapping addAttributesFromDictionary:@{@"farmID": @"farm"}];
    [mapping addAttributesFromDictionary:@{@"serverID": @"server"}];
    [mapping addAttributesFromDictionary:@{@"imageID": @"id"}];
    [mapping addAttributesFromDictionary:@{@"secret": @"secret"}];
    [mapping addAttributesFromDictionary:@{@"pictureTitle": @"title"}];
    [mapping addAttributesFromDictionary:@{@"isFamily": @"isfamily"}];
    [mapping addAttributesFromDictionary:@{@"isFriend": @"isfriend"}];
    [mapping addAttributesFromDictionary:@{@"isPublic": @"ispublic"}];
    [mapping addAttributesFromDictionary:@{@"owner": @"owner"}];
    
    return mapping;
}
@end

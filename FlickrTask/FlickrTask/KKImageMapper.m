//
//  KKImageMapper.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/21/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKImageMapper.h"

@implementation KKImageMapper

+ (FEMMapping *)defaultMapping
{
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[KKImageMapper class]];
    
    [mapping addAttributesFromDictionary:@{@"farmID": @"farm"}];
    [mapping addAttributesFromDictionary:@{@"serverID": @"server"}];
    [mapping addAttributesFromDictionary:@{@"imageID": @"id"}];
    [mapping addAttributesFromDictionary:@{@"secret": @"secret"}];
    [mapping addAttributesFromDictionary:@{@"imageTitle": @"title"}];
    [mapping addAttributesFromDictionary:@{@"isFamily": @"isfamily"}];
    [mapping addAttributesFromDictionary:@{@"isFriend": @"isfriend"}];
    [mapping addAttributesFromDictionary:@{@"isPublic": @"ispublic"}];
    [mapping addAttributesFromDictionary:@{@"owner": @"owner"}];
    
    return mapping;
}

@end

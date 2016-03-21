//
//  KKFlickrImageEntity.h
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/17/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <FEMMapping.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKFlickrImageEntity : NSManagedObject

+ (FEMMapping *)defaultMapping;

@end

NS_ASSUME_NONNULL_END

#import "KKFlickrImageEntity+CoreDataProperties.h"

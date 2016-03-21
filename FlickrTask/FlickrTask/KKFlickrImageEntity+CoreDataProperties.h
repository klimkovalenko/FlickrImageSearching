//
//  KKFlickrImageEntity+CoreDataProperties.h
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/21/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "KKFlickrImageEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKFlickrImageEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imageID;
@property (nullable, nonatomic, retain) NSString *pictureTitle;
@property (nullable, nonatomic, retain) NSString *imageURLString;
@property (nullable, nonatomic, retain) NSNumber *farmID;
@property (nullable, nonatomic, retain) NSNumber *isFamily;
@property (nullable, nonatomic, retain) NSNumber *isFriend;
@property (nullable, nonatomic, retain) NSNumber *isPublic;
@property (nullable, nonatomic, retain) NSString *owner;
@property (nullable, nonatomic, retain) NSString *secret;
@property (nullable, nonatomic, retain) NSString *serverID;

@end

NS_ASSUME_NONNULL_END

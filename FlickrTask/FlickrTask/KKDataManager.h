//
//  KKDataManager.h
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/15/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class KKFlickrImage;

@interface KKDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (KKDataManager *) sharedManager;

- (void)addNewFlickrImageWithTempFlickImage:(KKFlickrImage *)tempImage;
- (void)deleteAllObjects;
- (NSArray *)allOFlickrImages;
- (NSArray *)mappingWithJSON:(id)json;
- (NSArray *)arrayOfMathesImagesWithArrayOfTempImagesID:(NSArray *) array;
- (BOOL)flickrImageIDMatchTestWithTempImageID:(NSString *)tempImageID;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

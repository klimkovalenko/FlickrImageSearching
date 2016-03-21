//
//  KKDataManager.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/15/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKDataManager.h"
#import <FEMMapping.h>
#import <FEMDeserializer.h>
#import "KKFlickrImageEntity.h"
#import "KKFlickrImage.h"
#import "KKImageMapper.h"

@implementation KKDataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark External Methods

+ (KKDataManager *)sharedManager
{
    static KKDataManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KKDataManager alloc] init];
    });
    
    return manager;
}

#pragma mark - Adding and Deleting Objects

- (void)addNewFlickrImageWithTempFlickImage:(KKFlickrImage *)tempImage
{
    BOOL isMatch = [self flickrImageIDMatchTestWithTempImageID:tempImage.imageID];
    
    if (!isMatch) {
    
        KKFlickrImageEntity *flickrImage = [NSEntityDescription
                                            insertNewObjectForEntityForName:@"KKFlickrImageEntity"
                                            inManagedObjectContext:self.managedObjectContext];
    
        flickrImage.imageID = tempImage.imageID;
        flickrImage.pictureTitle = tempImage.imageTitle;
        flickrImage.imageURLString = tempImage.imageURLString;
        flickrImage.farmID = tempImage.farmID;
        flickrImage.isFamily = tempImage.isFamily;
        flickrImage.isFriend = tempImage.isFriend;
        flickrImage.isPublic = tempImage.isPublic;
        flickrImage.owner = tempImage.owner;
        flickrImage.secret = tempImage.secret;
        flickrImage.serverID = tempImage.serverID;
        
        NSError *error = nil;
    
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"ERROR: %@", [error localizedDescription]);
        }
    }
}

- (void)deleteAllObjects
{
    NSArray *array = [self allOFlickrImages];
    
    for (KKFlickrImageEntity *image in array) {
        [self.managedObjectContext deleteObject:image];
    }
    
    [self.managedObjectContext save:nil];
}

#pragma mark - Show All Objects

- (NSArray *)allOFlickrImages
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"KKFlickrImageEntity"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError *error = nil;
    
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return resultArray;
}

#pragma mark - Mapping

- (NSArray *)mappingWithJSON:(id)json
{
    FEMMapping *mapping = [KKImageMapper defaultMapping];
    
    NSArray *images = [FEMDeserializer collectionFromRepresentation:json mapping:mapping];

    return images;
}

#pragma mark - Matching

- (BOOL)flickrImageIDMatchTestWithTempImageID:(NSString *)tempImageID
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"KKFlickrImageEntity"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageID MATCHES %@", tempImageID];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"!!!%ld", resultArray.count);
    return resultArray.count > 0;
}

- (NSArray *)arrayOfMathesImagesWithArrayOfTempImagesID:(NSArray *) array
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"KKFlickrImageEntity"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"imageID IN %@", array];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *resultArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"!!!!!%ld", resultArray.count);

    return resultArray;
}

#pragma mark - Core Data stack

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FlickrTask" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"FlickrTask.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];

        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {

            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end

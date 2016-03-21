//
//  KKServerManager.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/15/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKServerManager.h"
#import <AFNetworking/AFNetworking.h>
#import "KKDataManager.h"
#import "KKFlickrImageEntity.h"
#import "KKFlickrImage.h"

@interface KKServerManager ()

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) NSString *flickrAPIRequestBody;

@end

@implementation KKServerManager

+ (KKServerManager *)sharedManager
{
    static KKServerManager * manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KKServerManager alloc] init];
    });
    
    return manager;
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        self.sessionManager = [[AFHTTPSessionManager alloc] init];
        
        self.flickrAPIRequestBody = @"https://api.flickr.com/services/rest";
    }
    
    return self;
}

- (void)getAttributesForImageURLWithSearchString:(NSString*)searchString
                                       onSuccess:(void(^)(NSArray *array))success
                                       onFailure:(void(^)(NSError *error, NSInteger sttusCode))failure
{
    NSDictionary *params = @{@"method": @"flickr.photos.search",
                             @"api_key": @"9bbafcc9f85e6bf24c20374d1680eab5",
                             @"text": searchString,
                             @"format": @"json",
                             @"nojsoncallback": @(1)};
    
    [self.sessionManager GET:self.flickrAPIRequestBody
                  parameters:params
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
         if ((responseObject && [responseObject objectForKey:@"photos"])) {
             
             NSDictionary *dictOfImages = [responseObject objectForKey:@"photos"];
             
             if ([dictOfImages objectForKey:@"photo"]) {
                 
                 NSArray *array = [[KKDataManager sharedManager] mappingWithJSON:[dictOfImages objectForKey:@"photo"]];
                 
                 NSArray *parsedArray = [KKFlickrImage imageParserWithResponseObject:array];
                 
                 success(parsedArray);
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         
     }];
}

@end












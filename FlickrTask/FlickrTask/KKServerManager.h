//
//  KKServerManager.h
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/15/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KKServerManager : NSObject

+ (KKServerManager*)sharedManager;

- (void)getAttributesForImageURLWithSearchString:(NSString*)searchString
                                       onSuccess:(void(^)(NSArray *array))success
                                       onFailure:(void(^)(NSError *error, NSInteger sttusCode))failure;

@end

//
//  KKImageDescriptionViewController.h
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/21/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKFlickrImageEntity.h"

@interface KKImageDescriptionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *descriptionImageView;

@property (strong, nonatomic) KKFlickrImageEntity *flickrImage;
@property (weak, nonatomic) IBOutlet UILabel *farmLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerLabel;
@property (weak, nonatomic) IBOutlet UILabel *secretLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

//
//  KKDetailImageViewController.h
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/21/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKCenteredScrollView.h"

@interface KKDetailImageViewController : UIViewController

@property (strong, nonatomic) UIImage *detailImage;
@property (weak, nonatomic) IBOutlet UIImageView *detailImageView;
@property (weak, nonatomic) IBOutlet KKCenteredScrollView *imgScrollView;

@end

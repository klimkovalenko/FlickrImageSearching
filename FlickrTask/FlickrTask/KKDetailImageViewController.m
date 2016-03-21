//
//  KKDetailImageViewController.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/21/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKDetailImageViewController.h"

@interface KKDetailImageViewController () <UIScrollViewDelegate>

@end

@implementation KKDetailImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.detailImageView.image = self.detailImage;
    
    [self.imgScrollView firstTimeShown:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.detailImageView;
}

@end

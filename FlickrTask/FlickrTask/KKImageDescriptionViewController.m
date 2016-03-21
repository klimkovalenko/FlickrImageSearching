//
//  KKImageDescriptionViewController.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/21/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKImageDescriptionViewController.h"
#import "KKDetailImageViewController.h"

@interface KKImageDescriptionViewController ()

@end

@implementation KKImageDescriptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.farmLabel.text = [NSString stringWithFormat:@"%@", self.flickrImage.farmID];
    self.idLabel.text = self.flickrImage.imageID;
    self.familyLabel.text = [NSString stringWithFormat:@"%@", self.flickrImage.isFamily];
    self.friendLabel.text = [NSString stringWithFormat:@"%@", self.flickrImage.isFriend];
    self.publicLabel.text = [NSString stringWithFormat:@"%@", self.flickrImage.isPublic];
    self.ownerLabel.text = self.flickrImage.owner;
    self.serverLabel.text = self.flickrImage.serverID;
    self.secretLabel.text = self.flickrImage.secret;
    self.titleLabel.text = self.flickrImage.pictureTitle;
    
    NSURL *url = [NSURL URLWithString:self.flickrImage.imageURLString];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    self.descriptionImageView.image = img;
    
    [self addTapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Internal Methods

- (void)handleImageTap:(UITapGestureRecognizer *)gesture
{
    [self performSegueWithIdentifier:@"ShowdetailImageViewController" sender:self.descriptionImageView.image];
}

- (void)addTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                               action:@selector(handleImageTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.cancelsTouchesInView = YES;
    [self.descriptionImageView addGestureRecognizer:singleTap];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    KKDetailImageViewController *vc = segue.destinationViewController;
    
    vc.detailImage = sender;
}

@end








//
//  ViewController.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/15/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "ViewController.h"
#import "KKServerManager.h"
#import "KKDataManager.h"
#import "KKCustomCollectionViewCell.h"
#import "KKFlickrImage.h"
#import "KKFlickrImageEntity.h"
#import "KKImageDescriptionViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()

@property (strong, nonatomic) NSArray *arrayOfFlickrImages;
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[KKDataManager sharedManager] deleteAllObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.arrayOfFlickrImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    KKCustomCollectionViewCell *cell = [collectionView
                                        dequeueReusableCellWithReuseIdentifier:identifier
                                        forIndexPath:indexPath];
    if (self.arrayOfFlickrImages) {
        
        KKFlickrImageEntity *flickrImage = [self.arrayOfFlickrImages objectAtIndex:indexPath.row];
        
        NSURL *url = [NSURL URLWithString:flickrImage.imageURLString];
        
        [cell.testImageView sd_setImageWithURL:url
                              placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        [self.hud hide:YES];
        
        cell.imageTitleLabel.text = [flickrImage.pictureTitle isEqualToString:@""]
            ? @"Flickr Image"
            : flickrImage.pictureTitle;
        
    }
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchBar.text = @"";
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self showMBProgressHud];
    
    [[KKServerManager sharedManager]
     getAttributesForImageURLWithSearchString:self.searchBar.text
     onSuccess:^(NSArray *array) {
         
         self.arrayOfFlickrImages = array;
         [self.picturesCollectionView reloadData];
         [[KKDataManager sharedManager] allOFlickrImages];
     }
     onFailure:^(NSError *error, NSInteger sttusCode) {
         
     }];

    [searchBar resignFirstResponder];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDescriptionView"]) {
        
        NSIndexPath *indexPath = [[self.picturesCollectionView indexPathsForSelectedItems]objectAtIndex:0];
        
        KKImageDescriptionViewController *vc = segue.destinationViewController;
        
        vc.flickrImage = [self.arrayOfFlickrImages objectAtIndex:indexPath.row];
    }
}

#pragma mark - Internal Methods

- (void)showMBProgressHud
{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.opacity = 0.4f;
    self.hud.labelText = @"Loading";
    self.hud.detailsLabelText = @"Please wait..";
}

@end























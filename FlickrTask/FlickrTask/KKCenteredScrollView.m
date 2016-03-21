//
//  KKCenteredScrollView.m
//  FlickrTask
//
//  Created by Klim Kovalenko on 3/21/16.
//  Copyright © 2016 Klim Kovalenko. All rights reserved.
//

#import "KKCenteredScrollView.h"

@interface KKCenteredScrollView ()

@property (assign, nonatomic) BOOL firstTime;

@end

@implementation KKCenteredScrollView

- (id)init
{
    self = [super init];
    if (self) {
        
        self.firstTime = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.firstTime) {
        [self setZoomScales];
    }
    
    [self centerContent];
    
    if (self.firstTime) {
        self.firstTime = NO;
    }
}

- (void)centerContent
{
    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        
        UIView *viewToCenter = [self.delegate viewForZoomingInScrollView:self];
        
        CGSize boundsSize = self.bounds.size;
        CGRect frameToCenter = viewToCenter.frame;
        
        if (frameToCenter.size.width < boundsSize.width) {
            
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
        } else {
            frameToCenter.origin.x = 0;
        }
        
        if (frameToCenter.size.height < boundsSize.height) {
            
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
        } else {
            frameToCenter.origin.y = 0;
        }
        
        viewToCenter.frame = frameToCenter;
    }
}

- (void)setZoomScales
{
    if ([self.delegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        
        UIView *viewToCenter = [self.delegate viewForZoomingInScrollView:self];
        
        CGSize boundsSize = self.bounds.size;
        CGSize contentSize = viewToCenter.bounds.size;
        
        CGFloat xScale = boundsSize.width / contentSize.width;
        CGFloat yScale = boundsSize.height / contentSize.height;
        CGFloat minScale = MIN(xScale, yScale);
        
        self.minimumZoomScale = minScale;
        self.zoomScale = minScale;
        self.maximumZoomScale =  3.0;
    }
}

- (void)firstTimeShown:(BOOL)isShow
{
    self.firstTime = isShow;
}


@end

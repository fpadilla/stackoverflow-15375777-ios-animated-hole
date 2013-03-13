//
//  ViewController.m
//  hole
//
//  Created by Rob Mayoff on 3/12/13.
//  Copyright (c) 2013 Rob Mayoff. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController {
    UIView *holeView;
}

- (void)loadView {
    UIView *const rootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
    [self addContentSubviews];
}

- (void)addContentSubviews {
    UIImageView *const imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Kaz-800.jpg"]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = self.view.bounds;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imageView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addHoleSubview];
}

- (void)viewDidLayoutSubviews {
    CGRect const bounds = self.view.bounds;
    holeView.center = CGPointMake(CGRectGetMidX(bounds), 0);

    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse animations:^{
            holeView.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMaxY(bounds));
        } completion:nil];
    });
}

- (void)addHoleSubview {
    holeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10000, 10000)];
    holeView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    holeView.autoresizingMask = 0;
    [self.view addSubview:holeView];
    [self addMaskToHoleView];
}

- (void)addMaskToHoleView {
    CGRect bounds = holeView.bounds;
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.fillColor = [UIColor blackColor].CGColor;

    static CGFloat const kRadius = 100;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(CGRectGetMidX(bounds) - kRadius, CGRectGetMidY(bounds) - kRadius, 2 * kRadius, 2 * kRadius)];
    [path appendPath:[UIBezierPath bezierPathWithRect:bounds]];
    maskLayer.path = path.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;

    holeView.layer.mask = maskLayer;
}

@end

//
//  DetailViewController.m
//  PhotoBombers
//
//  Created by Dale Rivera on 7/26/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "DetailViewController.h"
#import "PhotoController.h"
@interface DetailViewController ()
@property(nonatomic)UIImageView *imageView;
@property(nonatomic)UIDynamicAnimator *animator;
@end

@implementation DetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:.95];
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0, -320.0, 320.0, 320.0)];
    [self.view addSubview:self.imageView];
    [PhotoController imageForPhoto:self.photo size:@"standard_resolution" completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [self.view addGestureRecognizer:tap];
    
}
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.imageView snapToPoint:self.view.center];
    [self.animator addBehavior:snap];
}

-(void) close {
    [self.animator removeAllBehaviors];
    
    UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:self.imageView snapToPoint:CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetMaxY(self.view.bounds)+180.0f)];
    [self.animator addBehavior:snap];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

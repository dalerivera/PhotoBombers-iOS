//
//  PhotosViewController.m
//  PhotoBombers
//
//  Created by Dale Rivera on 7/25/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoCell.h"
#import "DetailViewController.h"
#import "PresentDetailTransition.h"
#import "DismissDetailTransition.h"
#import <SimpleAuth/SimpleAuth.h>

@interface PhotosViewController () <UIViewControllerTransitioningDelegate>
@property(nonatomic)NSString *accessToken;
@property(nonatomic)NSArray *photos;
@end

@implementation PhotosViewController
-(instancetype)init {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(106.0f, 106.0f);
    layout.minimumInteritemSpacing =1;
    layout.minimumLineSpacing = 1.0;
    return self = ([super initWithCollectionViewLayout:layout]);
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"Photo Bombers";
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PhotoCell class] forCellWithReuseIdentifier:@"photo"];
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSURL *url = [[NSURL alloc]initWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        NSString *text = [[NSString alloc] initWithContentsOfURL:location encoding:NSUTF8StringEncoding error:nil];
//        NSLog(@"Response: %@", text);
//    }];
//    [task resume];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.accessToken = [userDefaults objectForKey:@"accessToken"];
    if(self.accessToken == nil) {
        [SimpleAuth authorize:@"instagram" options:@{@"scope": @[@"likes"] } completion:^(NSDictionary *responseObject, NSError *error) {
            self.accessToken = responseObject[@"credentials"][@"token"];
            [userDefaults setObject:self.accessToken forKey:@"accessToken"];
            [userDefaults synchronize];
            [self refresh];
        }];
    }
    else {
        [self refresh];
        
    }
    
}

-(void) refresh {
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://api.instagram.com/v1/tags/photobomb/media/recent?access_token=%@",self.accessToken ];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.photos = [responseDictionary valueForKeyPath:@"data"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
    }];
    [task resume];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photos count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photo" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.photo = self.photos[indexPath.row];
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *photo = self.photos[indexPath.row];
    DetailViewController *viewController = [[DetailViewController alloc]init];
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate =self;
    viewController.photo = photo;
    [self presentViewController:viewController animated:YES completion:nil];
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[PresentDetailTransition alloc]init];
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[DismissDetailTransition alloc]init];
}
@end

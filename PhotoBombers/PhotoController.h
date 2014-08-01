//
//  PhotoController.h
//  PhotoBombers
//
//  Created by Dale Rivera on 7/26/14.
//  Copyright (c) 2014 example. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoController : NSObject
+(void)imageForPhoto:(NSDictionary *)photo size:(NSString *) size completion:(void(^) (UIImage *image)) completion;
@end

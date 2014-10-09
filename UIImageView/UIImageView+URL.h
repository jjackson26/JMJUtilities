//
//  UIImageView+URL.h
//  JMJUtilities
//
//  Created by J.J. Jackson on 2/27/13.
//

#import <UIKit/UIKit.h>

@interface UIImageView (URL) <NSURLConnectionDataDelegate>

/**
 * A url from which to download an image. The image will be asyncronously loaded and assigned to the
 * view upon completion.
 */
@property (nonatomic, strong) NSURL *imageURL;

/**
 * This property is used to enable an activity indicator which will can indicate to users when
 * the UIImageView is loading an image.
 */
@property (nonatomic, assign) BOOL useActivityIndicator;

- (instance)initWithImageURL:(NSURL *)imageURL;

@end

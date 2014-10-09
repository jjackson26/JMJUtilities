//
//  UIView+Screenshot.m
//  JMJUtilities
//
//  Created by J.J. Jackson on 03/10/14.
//

#import "UIView+Screenshot.h"

@implementation UIView (Screenshot)

- (UIImage *)screenshot {

    UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, [UIScreen mainScreen].scale);

    [self drawViewHierarchyInRect:self.bounds
               afterScreenUpdates:YES];

    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return screenshot;
}

@end

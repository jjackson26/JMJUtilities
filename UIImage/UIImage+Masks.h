//
//  UIImage+Masks.h
//  JMJUtilities
//
//  Created by J.J. Jackson on 18/09/14.
//

#import <UIKit/UIKit.h>

@interface UIImage (Masks)

+ (UIImage *)imageOfColor:(UIColor *)color
                     size:(CGSize)size;

+ (UIImage *)maskFromImage:(UIImage *)sourceImage;

+ (UIImage *)maskImage:(UIImage *)image
              withMask:(UIImage *)maskImage;

+ (UIImage *)colorizeImage:(UIImage *)sourceImage
                     color:(UIColor *)color;

@end

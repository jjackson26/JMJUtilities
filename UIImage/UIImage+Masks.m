//
//  UIImage+Masks.m
//  JMJUtilities
//
//  Created by J.J. Jackson on 18/09/14.
//

#import "UIImage+Masks.h"

@implementation UIImage (Masks)

+ (UIImage *)imageOfColor:(UIColor *)color
                     size:(CGSize)size {

    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIImage *)maskFromImage:(UIImage *)sourceImage {
    CGImageRef sourceImageRef = sourceImage.CGImage;
    CGImageRef maskImageRef = CGImageMaskCreate(CGImageGetWidth(sourceImageRef),
                                                CGImageGetHeight(sourceImageRef),
                                                CGImageGetBitsPerComponent(sourceImageRef),
                                                CGImageGetBitsPerPixel(sourceImageRef),
                                                CGImageGetBytesPerRow(sourceImageRef),
                                                CGImageGetDataProvider(sourceImageRef),
                                                NULL,
                                                false);

    return [UIImage imageWithCGImage:maskImageRef];
}

+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    CGImageRef maskSourceImageRef = maskImage.CGImage;
    CGImageRef maskImageRef = CGImageMaskCreate(CGImageGetWidth(maskSourceImageRef),
                                                CGImageGetHeight(maskSourceImageRef),
                                                CGImageGetBitsPerComponent(maskSourceImageRef),
                                                CGImageGetBitsPerPixel(maskSourceImageRef),
                                                CGImageGetBytesPerRow(maskSourceImageRef),
                                                CGImageGetDataProvider(maskSourceImageRef),
                                                NULL,
                                                false);


    CGImageRef maskedImageRef = CGImageCreateWithMask(image.CGImage, maskImageRef);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef];
    CGImageRelease(maskedImageRef);

    return maskedImage;
}

+ (UIImage *)colorizeImage:(UIImage *)sourceImage
                     color:(UIColor *)color {
    UIImage *colorImage = [UIImage imageOfColor:color
                                           size:sourceImage.size];

    UIImage *colorizedImage = [UIImage maskImage:colorImage
                                        withMask:sourceImage];
    return colorizedImage;
}

@end

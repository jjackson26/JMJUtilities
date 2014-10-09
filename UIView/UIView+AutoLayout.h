//
//  UIView+AutoLayout.h
//  JMJUtilities
//
//  Created by J.J. Jackson on 03/10/14.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayout)

+ (instancetype)autoLayoutView;

- (void)addConstraintsToMatchView:(UIView *)other
                       withInsets:(UIEdgeInsets)insets;

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views;

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views
                               metrics:(NSDictionary *)metrics;

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views
                               metrics:(NSDictionary *)metrics
                               options:(NSArray *)options;

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views
                               metrics:(NSDictionary *)metrics
                               options:(NSArray *)options
                             superview:(UIView *)superview;

- (void)addConstraintsToFillSuperView;

/**
 *  @param aspectRatio The ratio of view's constrained width to height
 */
- (void)addConstraintForAspectRatio:(CGFloat)aspectRatio;


@end

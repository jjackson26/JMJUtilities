//
//  UIView+AutoLayout.m
//  JMJUtilities
//
//  Created by J.J. Jackson on 03/10/14.
//

#import "UIView+AutoLayout.h"

@implementation UIView (AutoLayout)

+ (instancetype)autoLayoutView {
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views {
    [self addConstraintsForVisualFormats:visualFormats
                                   views:views
                                 metrics:nil];
}

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views
                               metrics:(NSDictionary *)metrics {
    [self addConstraintsForVisualFormats:visualFormats
                                   views:views
                                 metrics:metrics
                                 options:nil];
}

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views
                               metrics:(NSDictionary *)metrics
                               options:(NSArray *)options {
    [self addConstraintsForVisualFormats:visualFormats
                                   views:views
                                 metrics:metrics
                                 options:options
                               superview:nil];
}

+ (void)addConstraintsForVisualFormats:(NSArray *)visualFormats
                                 views:(NSDictionary *)views
                               metrics:(NSDictionary *)metrics
                               options:(NSArray *)allOptions
                             superview:(UIView *)superview {
    if (!superview) {
        NSString *key = views.allKeys.lastObject;
        UIView *view = views[key];
        superview = view.superview;
    }


    NSMutableArray *allConstraints = [NSMutableArray array];
    for (NSInteger i = 0; i < visualFormats.count; i++) {
        NSString *visualFormat = visualFormats[i];

        // get options if any
        NSLayoutFormatOptions options = 0;
        if (allOptions.count > i) {
            options = [allOptions[i] unsignedIntegerValue];
        }

        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat
                                                                       options:options
                                                                       metrics:metrics
                                                                         views:views];
        [allConstraints addObjectsFromArray:constraints];
    }
    [superview addConstraints:allConstraints];
}


#pragma mark - Instance methods

- (void)addConstraintsToFillSuperView {
    if (!self.superview) {
        return;
    }

    NSDictionary *views = @{ @"view": self };
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|"
                                                                           options:0
                                                                           metrics:nil
                                                                             views:views]];
}

- (void)addConstraintsToMatchView:(UIView *)other
                       withInsets:(UIEdgeInsets)insets
{
    if (!other) {
        return;
    }

    UIView *superview = self.superview;

    NSMutableArray *constraints = [NSMutableArray array];

    [constraints addObject:[NSLayoutConstraint constraintWithItem:self
                                                        attribute:NSLayoutAttributeTop
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:other
                                                        attribute:NSLayoutAttributeTop
                                                       multiplier:1
                                                         constant:insets.top]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self
                                                        attribute:NSLayoutAttributeLeft
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:other
                                                        attribute:NSLayoutAttributeLeft
                                                       multiplier:1
                                                         constant:insets.left]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self
                                                        attribute:NSLayoutAttributeBottom
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:other
                                                        attribute:NSLayoutAttributeBottom
                                                       multiplier:1
                                                         constant:insets.bottom]];
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self
                                                        attribute:NSLayoutAttributeRight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:other
                                                        attribute:NSLayoutAttributeRight
                                                       multiplier:1
                                                         constant:insets.right]];

    [superview addConstraints:constraints];
}

- (void)addConstraintForAspectRatio:(CGFloat)aspectRatio {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:aspectRatio
                                                      constant:0]];
}


@end

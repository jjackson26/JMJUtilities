//
//  NSJSONSerialization+Files.h
//  JMJUtilities
//
//  Created by J.J. Jackson on 10/7/14.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (Files)

+ (id)JSONObjectWithFileName:(NSString *)fileName
                     options:(NSJSONReadingOptions)options
                       error:(NSError **)error;

@end

//
//  NSDate+Refuge.m
//  refuge-ios
//
//  Created by Harlan Kellaway on 2/4/15.
//  Copyright (c) 2015 Refuge Restrooms. All rights reserved.
//

#import "NSDate+Refuge.h"

static NSString * const kRefgueDateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";

@implementation NSDate (Refuge)

# pragma mark - Public methods

+ (NSString *)dateFormat
{
    return kRefgueDateFormat;
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    return [self.dateFormatter dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    return [self.dateFormatter stringFromDate:date];
}

# pragma mark - Private methods

+ (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = kRefgueDateFormat;
    
    return dateFormatter;
}

@end

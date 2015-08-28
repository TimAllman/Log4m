//
//  LogLevel.h
//  log4m
//
//  Created by Tim Allman on 2013-04-28.
//  Copyright (c) 2013 Tim Allman. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Logging levels. These values must be synchronised with those in log4cplus.
 */
enum
{
    LOG4M_LEVEL_OFF = 60000,
    LOG4M_LEVEL_FATAL = 50000,
    LOG4M_LEVEL_ERROR = 40000,
    LOG4M_LEVEL_WARN = 30000,
    LOG4M_LEVEL_INFO = 20000,
    LOG4M_LEVEL_DEBUG = 10000,
    LOG4M_LEVEL_TRACE = 0,
    LOG4M_LEVEL_ALL = LOG4M_LEVEL_TRACE,
    LOG4M_LEVEL_NOT_SET = -1,
};

@interface LogLevel : NSObject

/**
 * Turn the numeric level into a string.
 * @param levelString
 */
+ (int)fromString:(NSString*)levelString;

/**
 * Turn the numeric level into a string.
 * @param level The numeric level.
 * @return A human readable string.
 */
+ (NSString*)toString:(int)level;

@end


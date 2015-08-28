//
//  LogLevel.h
//  log4m
//

/* Log4m is an Obj-C front end for the C++ logger log4cplus
 * (http://sourceforge.net/p/log4cplus/wiki/Home/ ).
 * Copyright (C) 2014  Tim Allman
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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


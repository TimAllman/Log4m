//
//  main.m
//  tests
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

#import "SetupLogger.h"

#import "Log4m.h"

#define LOGGER_NAME "TestLogger"

int main(int argc, const char * argv[])
{
    int success = SetupLogger("TestLogger", LOG4M_LEVEL_ALL);
    if (success != 0)
        return EXIT_FAILURE;

    NSString* loggerName = [[NSString stringWithUTF8String:LOGGER_NAME]
                            stringByAppendingString:@".NewLogger"];

    Logger* logger = [Logger newInstance:loggerName];
    LOG4M_INFO(logger, @"Log message");

    NSString* levelString = [LogLevel toString:LOG4M_LEVEL_TRACE];
    LOG4M_INFO(logger, @"Trace string = %@", levelString);

    levelString = [LogLevel toString:LOG4M_LEVEL_DEBUG];
    LOG4M_INFO(logger, @"Debug string = %@", levelString);

    levelString = [LogLevel toString:LOG4M_LEVEL_INFO];
    LOG4M_INFO(logger, @"Info string = %@", levelString);

    levelString = [LogLevel toString:LOG4M_LEVEL_WARN];
    LOG4M_INFO(logger, @"Warn string = %@", levelString);

    levelString = [LogLevel toString:LOG4M_LEVEL_ERROR];
    LOG4M_INFO(logger, @"Error string = %@", levelString);

    levelString = [LogLevel toString:LOG4M_LEVEL_FATAL];
    LOG4M_INFO(logger, @"Fatal string = %@", levelString);

    levelString = [LogLevel toString:LOG4M_LEVEL_OFF];
    LOG4M_INFO(logger, @"Off string = %@", levelString);

    return EXIT_SUCCESS;
}

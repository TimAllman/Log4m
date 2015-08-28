//
//  main.m
//  tests
//
//  Created by Tim Allman on 2014-10-07.
//  Copyright (c) 2014 Tim Allman. All rights reserved.
//

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

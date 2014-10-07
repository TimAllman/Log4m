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

    return EXIT_SUCCESS;
}

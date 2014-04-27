//
//  LoggingMacros.mm
//  Log4m
//
//  Created by Tim Allman on 2013-05-09.
//  Copyright (c) 2013 Tim Allman. All rights reserved.
//


#import <Log4m/Logger.h>
#import <Log4m/LoggingMacros.h>

#include <log4cplus/loggingmacros.h>

void macro_forced_log(Logger* logger, int level,
                            NSString* message, const char* filename,
                            int line, const char* function)
{
    log4cplus::Logger cLogger = log4cplus::Logger::getInstance([logger.name UTF8String]);
    log4cplus::tstring msg = [message UTF8String];

    log4cplus::detail::macro_forced_log (cLogger, level, msg, filename, line, function);
}

NSString* formatMsg(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    return [[[NSString alloc] initWithFormat:format arguments:args] autorelease];
    va_end(args);
}

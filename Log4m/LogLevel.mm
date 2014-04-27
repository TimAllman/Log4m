//
//  LogLevel.m
//  log4m
//
//  Created by Tim Allman on 2013-04-28.
//  Copyright (c) 2013 Tim Allman. All rights reserved.
//

#import <Log4m/LogLevel.h>

#include <log4cplus/loglevel.h>

@implementation LogLevel

+ (int)fromString:(NSString*)levelString
{
    const char* levelStr = [levelString UTF8String];
    log4cplus::LogLevelManager& llm = log4cplus::getLogLevelManager();
    int level = llm.fromString(log4cplus::tstring(levelStr));
    
    return level;
}

+ (NSString*)toString:(int)level
{
    log4cplus::LogLevelManager& llm = log4cplus::getLogLevelManager();

    log4cplus::tstring str = llm.toString(level);

    return [NSString stringWithUTF8String:str.c_str()];
}

@end


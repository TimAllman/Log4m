//
//  Logger.m
//  log4m
//
//  Created by Tim Allman on 2013-04-28.
//  Copyright (c) 2013 Tim Allman. All rights reserved.
//

#import <Log4m/Logger.h>
#import <Log4m/LogLevel.h>

#include <log4cplus/logger.h>
#include <log4cplus/loggingmacros.h>

@implementation Logger

@synthesize name = name_;

- (Logger*)initWithName:(NSString*)name
{
    self = [super init];
    if (self)
    {
        name_ = [[NSString stringWithString:name] copy];
    }
    return self;
}

- (void)dealloc
{
    [name_ release];
    [super dealloc];
}

- (void)setLevel:(int)level
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);
    logger.setLogLevel(level);
}

- (BOOL)isEnabledFor:(int)level
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);
    return logger.isEnabledFor(level);
}

- (void)forcedLog:(int)level Message:(NSString*)format, ...
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);
    va_list args;
    va_start(args, format);
    NSString* msg = [[[NSString alloc] initWithFormat:format arguments:args] autorelease];
    va_end(args);
    std::string m = [msg UTF8String];
    logger.forcedLog(level, m);
}

- (void)setAdditivity:(BOOL)additivity
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);

    logger.setAdditivity(additivity);
}

- (BOOL)getAdditivity
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);
    
    return logger.getAdditivity();
}

- (int)getLevel
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);

    return logger.getLogLevel();
}

- (Logger *)getParent
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);
    log4cplus::Logger parent = logger.getParent();
    name = logger.getName();
    NSString* ocname = [NSString stringWithUTF8String:name.c_str()];

    return [[[Logger alloc] initWithName:ocname] autorelease];
}

- (void)log:(int)level Message:(NSString *)format, ...
{
    std::string name = [self.name UTF8String];
    log4cplus::Logger logger = log4cplus::Logger::getInstance(name);
    va_list args;
    va_start(args, format);
    NSString* msg = [[[NSString alloc] initWithFormat:format arguments:args] autorelease];
    va_end(args);
    std::string m = [msg UTF8String];

    logger.log(level, m);
}

+ (id)newInstance:(id)ident
{
    if ([ident isKindOfClass:[Logger class]])
        return ident;
    else if ([ident isKindOfClass:[NSString class]])
        return [[Logger alloc] initWithName:ident];
    else
        return nil;
}

+ (Logger*)newRoot
{
    return [Logger newInstance:@"root"];
}

+ (BOOL)exists:(NSString *)name
{
    return log4cplus::Logger::exists(std::string([name UTF8String]));
}

+ (void)shutdown
{
    log4cplus::Logger::shutdown();
}

@end

//
//  Logger.m
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

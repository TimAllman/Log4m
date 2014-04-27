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
// #include <log4cplus/appender.h>
// #include <log4cplus/consoleappender.h>
// #include <log4cplus/fileappender.h>
// #include <log4cplus/socketappender.h>
// #include <log4cplus/layout.h>
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

// - (void)addAppender:(Appender*)appender
// {
//     std::string cname = [self.name UTF8String];
//     log4cplus::Logger logger = log4cplus::Logger::getInstance(cname);
//     log4cplus::SharedAppenderPtr app;

//     if ([appender isKindOfClass: [ConsoleAppender class]])
//     {
//         app = new log4cplus::ConsoleAppender();
//     }
//     else if ([appender isKindOfClass: [SocketAppender class]])
//     {
//         SocketAppender* sapp = (SocketAppender*)appender;
//         std::string serverName = [sapp.server UTF8String];
//         unsigned port = sapp.port;
//         std::string host = "127.0.0.1";
//         app = new log4cplus::SocketAppender(host, port, serverName);
//     }
//     else if ([appender isKindOfClass: [RollingFileAppender class]])
//     {
//         RollingFileAppender* rfapp = (RollingFileAppender*)appender;
//         std::string fname = [rfapp.fileName UTF8String];
//         app = new log4cplus::RollingFileAppender(fname, rfapp.maxFileSize,
//                     rfapp.maxBackupIndex, (bool)rfapp.immediateFlush);
//     }
//     else if ([appender isKindOfClass: [FileAppender class]])
//     {
//         FileAppender* fapp = (FileAppender*)appender;
//         std::string fname = [fapp.fileName UTF8String];
//         app = new log4cplus::FileAppender(fname);
//     }

//     if (appender.name != nil)
//     {
//         std::string appName;
//         appName = [appender.name UTF8String];
//         app->setName(appName);
//     }

//     if ([appender.layout isKindOfClass: [SimpleLayout class]])
//     {
//         std::auto_ptr<log4cplus::Layout> layout(new log4cplus::SimpleLayout());
//         app->setLayout(layout);
//     }
//     else if ([appender.layout isKindOfClass: [PatternLayout class]])
//     {
//         PatternLayout* lo = (PatternLayout*)appender.layout;
//         std::string pat = [lo.pattern UTF8String];
//         std::auto_ptr<log4cplus::Layout> layout(new log4cplus::PatternLayout(pat));
//         app->setLayout(layout);
//     }

//     app->setThreshold(appender.threshold);
//     logger.addAppender(app);
// }

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

// - (void)removeAppender:(NSString *)name
// {
//     std::string appName = [self.name UTF8String];
//     std::string logName = [self.name UTF8String];
//     log4cplus::Logger logger = log4cplus::Logger::getInstance(logName);
//     logger.removeAppender(appName);
// }

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

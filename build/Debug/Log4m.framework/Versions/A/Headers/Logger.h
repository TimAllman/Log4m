//
//  Logger.h
//  log4m
//
//  Created by Tim Allman on 2013-04-28.
//  Copyright (c) 2013 Tim Allman. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Log4m/LogLevel.h>

@class Appender;

@interface Logger : NSObject
{
    NSString* name_;
}

@property (copy) NSString* name;

- (Logger*)initWithName:(NSString*)name;

- (void)setLevel:(int)level;

- (BOOL)isEnabledFor:(int)level;

- (void)forcedLog:(int)level Message:(NSString*)format, ...;

- (void)setAdditivity:(BOOL)additivity;

- (BOOL)getAdditivity;

- (int)getLevel;

- (Logger*)getParent;

- (void)log:(int)level Message:(NSString*)format, ...;

+ (id)newInstance:(id)ident;

+ (Logger*)newRoot;

+ (BOOL)exists:(NSString*)name;

+ (void)shutdown;

@end


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

/**
 * Obj-C Logger class. This carries only the name of the underlying log4cplus logger.
 * Although you can call these methods, it is generally more convenient to use
 * the macros in LoggingMacros.h
 */
@interface Logger : NSObject
{
    NSString* name_; ///> The name of the underlying log4cplus logger.
}

/**
 * The name of the underlying log4cplus logger. Once set it cannot be changed.
 */
@property (copy, readonly) NSString* name;

/**
 * Init the instance with the name of the logger.
 * @param The name of the logger.
 * @return Initialised instance.
 */
- (Logger*)initWithName:(NSString*)name;

/**
 * Set the logging level.
 * @param level Use one of the levels defined in LogLevel.h.
 */
- (void)setLevel:(int)level;

/**
 * Get the logging level.
 * @return The current level. It will be one of the levels defined in LogLevel.h.
 */
- (int)getLevel;

/**
 * Check whether logger is enabled for a logging level.
 * @param level Use one of the levels defined in LogLevel.h.
 */
- (BOOL)isEnabledFor:(int)level;

/**
 * Log a message if permitted by the current logger level.
 * @param level The level of the message.
 * @param format Obj-C string format.
 */
- (void)log:(int)level Message:(NSString*)format, ...;

/**
 * Force a logging message regardless of current logger level.
 * @param level The level of the message.
 * @param format Obj-C string format.
 */
- (void)forcedLog:(int)level Message:(NSString*)format, ...;

/**
 * Set the additivity property for the log4cplus logger.
 * @param additivity Pass YES or NO to turn it on or off.
 */
- (void)setAdditivity:(BOOL)additivity;

/**
 * Get the additivity property for the log4cplus logger.
 * @return YES or NO if on or off.
 */
- (BOOL)getAdditivity;

/**
 * Get the parent logger.
 * @return The logger which is the parent of this one.
 */
- (Logger*)getParent;

/**
 * Factory method to create a new logger. This is the preferred way to do it.
 * @param ident This can be the name of the new logger or an instance to clone.
 * @return The new instance or nil if logger cannot be made.
 */
+ (id)newInstance:(id)ident;

/**
 * Factory method to create a new root logger. This is the preferred way to do it.
 * @return The new instance or nil if logger cannot be made althoughit should never fail.
 */
+ (Logger*)newRoot;

/**
 * See if a logger exists.
 * @param name The name of the logger to query.
 * @return YES or NO
 */
+ (BOOL)exists:(NSString*)name;

/**
 * Shut down the logging system.
 */
+ (void)shutdown;

@end


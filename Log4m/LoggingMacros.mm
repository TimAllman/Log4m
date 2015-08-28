//
//  LoggingMacros.mm
//  Log4m
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
#import <Log4m/LoggingMacros.h>

#include <log4cplus/loggingmacros.h>

/**
 Logs a message to a specified logger. This function is the interface
 to the log4cplus library.

 @param logger The logger to be used.
 @param level the level to log.
 @param message The formatted logging message.
 @param filename The filename of the source file. (__LINE__)
 @param line The line number of the logging call. (__FILE__)
 @param function The function making the logging call. (__FUNCTION__)
 */
void macro_force_log(Logger* logger, int level, NSString* message, const char* filename,
                     int line, const char* function)
{
    log4cplus::Logger cLogger = log4cplus::Logger::getInstance([logger.name UTF8String]);
    log4cplus::tstring msg = [message UTF8String];

    log4cplus::detail::macro_forced_log(cLogger, level, msg, filename, line, function);
}

/**
 * Format a message.
 @param format The formatting information.
 @return A NSString instance, properly formatted.
 */
NSString* formatMsg(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    return [[[NSString alloc] initWithFormat:format arguments:args] autorelease];
    va_end(args);
}

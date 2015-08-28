//
//  Macros.h
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

#ifndef Log4m_Macros_h
#define Log4m_Macros_h

@class Logger;

#import <Log4m/LogLevel.h>


/**
 The macro which is called by the others. This should never be called in code.

 @param logger The logger to be used.
 @param logLevel the level to log.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_MACRO_BODY(logger, logLevel, format, ...)                            \
{                                                                                  \
    if ([logger isEnabledFor:logLevel])                                            \
    {                                                                              \
        NSString* msg = formatMsg(format, ##__VA_ARGS__);                          \
        macro_force_log(logger, logLevel, msg, __FILE__, __LINE__, __FUNCTION__);  \
    }                                                                              \
}

/**
 Logs a message to a specified logger with a specified level.

 @param logger The logger to be used.
 @param level the level to log.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_LOG(logger, level, format, ...)          \
LOG4M_MACRO_BODY(logger, level, format, ##__VA_ARGS__)

/**
 Logs a message to a specified logger with the TRACE level.

 @param logger The logger to be used.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_TRACE(logger, format, ...)                           \
LOG4M_MACRO_BODY(logger, LOG4M_LEVEL_TRACE, format, ##__VA_ARGS__)

/**
 Logs a message to a specified logger with the DEBUG level.

 @param logger The logger to be used.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_DEBUG(logger, format, ...)                           \
LOG4M_MACRO_BODY(logger, LOG4M_LEVEL_DEBUG, format, ##__VA_ARGS__)

/**
 Logs a message to a specified logger with the INFO level.

 @param logger The logger to be used.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_INFO(logger, format, ...)                           \
LOG4M_MACRO_BODY(logger, LOG4M_LEVEL_INFO, format, ##__VA_ARGS__)

/**
 Logs a message to a specified logger with the WARN level.

 @param logger The logger to be used.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_WARN(logger, format, ...)                           \
LOG4M_MACRO_BODY(logger, LOG4M_LEVEL_WARN, format, ##__VA_ARGS__)

/**
 Logs a message to a specified logger with the ERROR level.

 @param logger The logger to be used.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_ERROR(logger, format, ...)                           \
LOG4M_MACRO_BODY(logger, LOG4M_LEVEL_ERROR, format, ##__VA_ARGS__)

/**
 Logs a message to a specified logger with the FATAL level.

 @param logger The logger to be used.
 @param format The message format string.
 @param ... The variable arguments for the format.
 */
#define LOG4M_FATAL(logger, format, ...)                           \
LOG4M_MACRO_BODY(logger, LOG4M_LEVEL_FATAL, format, ##__VA_ARGS__)

#ifdef __cplusplus
extern "C"
{
#endif

    /**
     * Log a message, potentially with location information.
     *
     * @param logger The logger to use.
     * @param logLevel The level of the message.
     * @param message The message, already formatted.
     * @param filename The result of __FILE__.
     * @param line The result of __LINE__.
     * @param function The result of __func__.
     */
    void macro_force_log(Logger* logger, int logLevel, NSString* message,
                         const char* filename, int line, const char* function);

    /**
     * Do the vsprintf type formatting of the message.
     *
     * @param format The message format string.
     * @param ... The variable arguments.
     * @return The formatted string, autoreleased.
     */
    NSString* formatMsg(NSString* format, ...);

#ifdef __cplusplus
}
#endif

#endif

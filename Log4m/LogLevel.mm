//
//  LogLevel.m
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


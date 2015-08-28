//
//  SetupLogger.mm
//  TestLib
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

#include "SetupLogger.h"

#include <log4cplus/loglevel.h>
#include <log4cplus/logger.h>
#include <log4cplus/consoleappender.h>
#include <log4cplus/fileappender.h>
#include <log4cplus/loggingmacros.h>

int SetupLogger(const char* name, int level)
{
    std::string loggerName(name);

    // The logger is set to log all messages. We use the appenders to restrict the output(s).
    log4cplus::Logger logger = log4cplus::Logger::getInstance(loggerName);
    logger.setLogLevel(level);

    // The console appender
    log4cplus::SharedAppenderPtr consoleAppender(new log4cplus::ConsoleAppender);
    std::string consoleAppName = loggerName + ".console";
    consoleAppender->setName(consoleAppName);
    consoleAppender->setThreshold(log4cplus::INFO_LOG_LEVEL);
    std::string consolePattern = "%-5p (%d{%q}) [%b:%L] %m%n";
    std::auto_ptr<log4cplus::Layout> layout(new log4cplus::PatternLayout(consolePattern));
    consoleAppender->setLayout(layout);

    logger.addAppender(consoleAppender);

    // Generate the name of the rolling file in $HOME/Library/Logs
    std::string homeDir = getenv("HOME");
    std::string logFileName = loggerName + ".log";
    std::string logFilePath = homeDir + "/Library/Logs/" + logFileName;

    std::string logFileAppName = loggerName + ".file";
    log4cplus::SharedAppenderPtr
    logFileApp(new log4cplus::RollingFileAppender(logFilePath, 1000000, 5, false));
    logFileApp->setName(logFileAppName);
    std::string filePattern = "%-5p [%d{%y-%m-%d %H:%M:%S:%q}][%b:%L] %m%n";
    std::auto_ptr<log4cplus::Layout> fileLayout(new log4cplus::PatternLayout(filePattern));
    logFileApp->setLayout(fileLayout);
    logFileApp->setThreshold(log4cplus::TRACE_LOG_LEVEL);
    logger.addAppender(logFileApp);

    LOG4CPLUS_INFO(logger, "Logging to file: " << logFilePath);

    return 0;
}

# This file is part of Desktop App Toolkit,
# a set of libraries for developing nice desktop applications.
#
# For license and copyright information please follow this link:
# https://github.com/desktop-app/legal/blob/master/LEGAL

if (NOT DESKTOP_APP_USE_PACKAGED)
    if (NOT APPLE OR NOT build_osx)
        set(qt_version 5.12.5)
    else()
        set(qt_version 5.6.2)
    endif()

    if (WIN32)
        set(qt_loc ${libs_loc}/Qt-${qt_version})
    else()
        set(qt_loc /usr/local/desktop-app/Qt-${qt_version})
    endif()

    set(Qt5_DIR ${qt_loc}/lib/cmake/Qt5)
endif()

find_package(Qt5 COMPONENTS Core Gui Widgets Network REQUIRED)

if (LINUX)
    find_package(Qt5 COMPONENTS DBus)
endif()

set_property(GLOBAL PROPERTY AUTOGEN_SOURCE_GROUP "(gen)")
set_property(GLOBAL PROPERTY AUTOGEN_TARGETS_FOLDER "(gen)")

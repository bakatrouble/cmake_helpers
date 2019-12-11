# This file is part of Desktop App Toolkit,
# a set of libraries for developing nice desktop applications.
#
# For license and copyright information please follow this link:
# https://github.com/desktop-app/legal/blob/master/LEGAL

function(init_target_folder target_name folder_name)
    if (NOT "${folder_name}" STREQUAL "")
        set_target_properties(${target_name} PROPERTIES FOLDER ${folder_name})
    endif()
endfunction()

function(init_target target_name) # init_target(my_target folder_name)
    if (ARGC GREATER 1)
        if (${ARGV1} STREQUAL cxx_std_14 OR ${ARGV1} STREQUAL cxx_std_11)
            target_compile_features(${target_name} PUBLIC ${ARGV1})
        else()
            target_compile_features(${target_name} PUBLIC cxx_std_20)
            init_target_folder(${target_name} ${ARGV1})
        endif()
    else()
        target_compile_features(${target_name} PUBLIC cxx_std_20)
    endif()
    if (WIN32)
        set_target_properties(${target_name} PROPERTIES
            MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    endif()
    target_link_libraries(${target_name} PUBLIC desktop-app::common_options)
    set_target_properties(${target_name} PROPERTIES
        LINK_SEARCH_START_STATIC 1
        XCODE_ATTRIBUTE_CLANG_ENABLE_OBJC_WEAK YES
        XCODE_ATTRIBUTE_GCC_INLINES_ARE_PRIVATE_EXTERN YES
        XCODE_ATTRIBUTE_GCC_SYMBOLS_PRIVATE_EXTERN YES
        XCODE_ATTRIBUTE_GCC_OPTIMIZATION_LEVEL $<IF:$<CONFIG:Debug>,0,fast>
        XCODE_ATTRIBUTE_LLVM_LTO $<IF:$<CONFIG:Debug>,NO,YES>
    )
    if (WIN32)
        set_target_properties(${target_name} PROPERTIES
            INTERPROCEDURAL_OPTIMIZATION_RELEASE True
            INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO True
            INTERPROCEDURAL_OPTIMIZATION_MINSIZEREL True
        )
    endif()
endfunction()

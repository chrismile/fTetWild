get_filename_component(_IMPORT_PREFIX "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)
get_filename_component(_IMPORT_PREFIX "${_IMPORT_PREFIX}" PATH)

set(fTetWild_VERSION 0.1.0)

add_library(fTetWild::static STATIC IMPORTED GLOBAL)

#target_include_directories(fTetWild::static INTERFACE "${_IMPORT_PREFIX}/include")
set_target_properties(fTetWild::static PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${_IMPORT_PREFIX}/include"
)

if (EMSCRIPTEN)
    set_target_properties(fTetWild::static PROPERTIES
        IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libFloatTetwild.a"
    )
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set_target_properties(fTetWild::static PROPERTIES
        IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libFloatTetwild.a"
    )
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    if(EXISTS "${_IMPORT_PREFIX}/lib/FloatTetwild.lib")
        # MSVC
        set_target_properties(fTetWild::static PROPERTIES
            IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/FloatTetwild.lib"
            IMPORTED_IMPLIB "${_IMPORT_PREFIX}/lib/FloatTetwild.lib"
        )
    else()
        # E.g., MinGW
        set_target_properties(fTetWild::static PROPERTIES
            IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libFloatTetwild.a"
        )
    endif()
elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set_target_properties(fTetWild::static PROPERTIES
        IMPORTED_LOCATION "${_IMPORT_PREFIX}/lib/libFloatTetwild.a"
    )
else()
    message(FATAL_ERROR "System currently not supported by fTetWild.")
endif()

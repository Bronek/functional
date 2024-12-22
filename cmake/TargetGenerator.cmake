# Target generator to enforce that a HEADER file compiles cleanly with no additional includes

function(setup_target_for_header)
    set(oneValueArgs SUFFIX HEADER SOURCE_ROOT)
    set(multiValueArgs DEPENDENCIES OPTIONS)
    cmake_parse_arguments(Generator "" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    if(NOT DEFINED Generator_HEADER)
        message(FATAL_ERROR "HEADER must be set")
    endif()

    if(NOT DEFINED Generator_SUFFIX)
        # Deduce from the HEADER suffix
        string(REGEX REPLACE "^.*[\\.]([a-zA-Z]+)$" "\\\\.\\1" Generator_SUFFIX ${Generator_HEADER})
    endif()

    if(NOT DEFINED Generator_SOURCE_ROOT)
        set(Generator_SOURCE_ROOT "${CMAKE_BINARY_DIR}/generated")
    endif()

    set(FILE_TEMPLATE "#include <>\nint main() {}\n")
    string(REPLACE "include <>" "include <${Generator_HEADER}>" file_content ${FILE_TEMPLATE})
    string(REGEX REPLACE "^(.*)${Generator_SUFFIX}$" "${Generator_SOURCE_ROOT}/\\1_Main.cpp" file_name ${Generator_HEADER})
    string(REGEX REPLACE "[\\./]" "-" target_name ${Generator_HEADER})

    file(WRITE ${file_name} "${file_content}")

    add_executable(${target_name} ${file_name})

    target_link_libraries(${target_name} ${Generator_DEPENDENCIES})

    target_compile_options(${target_name} PRIVATE ${Generator_OPTIONS})
endfunction()

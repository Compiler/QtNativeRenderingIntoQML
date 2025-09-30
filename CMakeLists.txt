cmake_minimum_required(VERSION 3.16)

project(TestWindowing VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

include(FetchContent)
FetchContent_Declare(
  glfw
  GIT_REPOSITORY https://github.com/glfw/glfw.git
  GIT_TAG 3.4
)

set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS    OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_DOCS     OFF CACHE BOOL "" FORCE)
set(GLFW_INSTALL        OFF CACHE BOOL "" FORCE)

FetchContent_MakeAvailable(glfw)

qt_add_executable(appTestWindowing
    main.cpp
)

qt_add_qml_module(appTestWindowing
    URI TestWindowing
    VERSION 1.0
    QML_FILES
        Main.qml
)

set_target_properties(appTestWindowing PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appTestWindowing
    PRIVATE
        Qt6::Quick
        glfw               # <-- link GLFW
)

target_compile_definitions(appTestWindowing PRIVATE GLFW_EXPOSE_NATIVE_WIN32)
# If you include <GLFW/glfw3.h> but don't want GL headers pulled in by GLFW:
# target_compile_definitions(appTestWindowing PRIVATE GLFW_INCLUDE_NONE)

# (Optional) Static CRT / MT runtime for MSVC builds:
# if(MSVC)
#   set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
# endif()

include(GNUInstallDirs)
install(TARGETS appTestWindowing
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# ---- Alternative: if you use vcpkg or have glfw installed, replace the FetchContent block with:
# find_package(glfw3 CONFIG REQUIRED)
# target_link_libraries(appTestWindowing PRIVATE glfw)

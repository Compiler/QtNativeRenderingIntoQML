# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "RelWithDebInfo")
  file(REMOVE_RECURSE
  "CMakeFiles\\appTestWindowing_autogen.dir\\AutogenUsed.txt"
  "CMakeFiles\\appTestWindowing_autogen.dir\\ParseCache.txt"
  "_deps\\glfw-build\\src\\CMakeFiles\\glfw_autogen.dir\\AutogenUsed.txt"
  "_deps\\glfw-build\\src\\CMakeFiles\\glfw_autogen.dir\\ParseCache.txt"
  "_deps\\glfw-build\\src\\glfw_autogen"
  "appTestWindowing_autogen"
  )
endif()

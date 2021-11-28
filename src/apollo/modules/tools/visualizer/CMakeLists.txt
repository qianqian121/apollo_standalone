cmake_minimum_required(VERSION 3.5.1)
project(visualizer)

FILE(GLOB SRC_FILES "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")
list(REMOVE_ITEM SRC_FILES "main.cc")
set(CMAKE_AUTOUIC_SEARCH_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/uis)
add_executable(cyber_visualizer main.cc ${SRC_FILES} res.qrc)
target_include_directories(cyber_visualizer PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${FastRTPS_INCLUDE_DIR})
target_link_libraries(cyber_visualizer
        cyber::cyber_core
        drivers::proto
        ${FastRTPS_LIBRARIES}
        ${Qt5Widgets_LIBRARIES}
        ${Qt5Core_LIBRARIES}
        ${Qt5Gui_LIBRARIES}
        ${Qt5OpenGL_LIBRARIES}
        ${OPENGL_gl_LIBRARY})
set_property(TARGET cyber_visualizer PROPERTY AUTOMOC ON)
set_property(TARGET cyber_visualizer PROPERTY AUTOUIC ON)
set_property(TARGET cyber_visualizer PROPERTY AUTORCC ON)
target_compile_options(cyber_visualizer PRIVATE -fPIC)

install(TARGETS cyber_visualizer
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
)

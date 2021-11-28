cmake_minimum_required(VERSION 3.5.1)

file(GLOB PROTOS *.proto)

PROTOBUF_GENERATE_CPP(PROTO_SRCS PROTO_HDRS ${PROTOS})

include_directories(${PROTOBUF_INCLUDE_DIRS})

add_library(drivers_proto ${PROTO_SRCS} ${PROTO_HDRS})
target_link_libraries(drivers_proto
        common::proto
        ${PROTOBUF_LIBRARIES}
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}>)
add_library(drivers::proto ALIAS drivers_proto)

install(TARGETS drivers_proto
        EXPORT  apollo-export
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

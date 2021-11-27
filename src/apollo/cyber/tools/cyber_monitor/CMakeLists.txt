cmake_minimum_required(VERSION 3.5)
project(CyberMonitor)

add_executable(cyber_monitor
    cyber_topology_message.cc
    general_channel_message.cc
    general_message_base.cc
    general_message.cc
    main.cc
    renderable_message.cc
    screen.cc
    )

target_link_libraries(cyber_monitor
    pthread
    ncurses
    ${gflags_LIBRARIES}
    cyber::init
    cyber::component_base
    cyber::cyber_core
    cyber::blocker_manager
    cyber::endpoint
    )

file(GLOB HEADERS *.h)

install(FILES ${HEADERS}
    DESTINATION ${CYBER_INSTALL_INCLUDE_DIR}/cyber/monitor
    )

install(TARGETS cyber_monitor
    DESTINATION  ${CYBER_INSTALL_DIR}/bin
    )

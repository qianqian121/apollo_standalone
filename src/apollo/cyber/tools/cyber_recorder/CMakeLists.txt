cmake_minimum_required(VERSION 3.5)
project(CyberRecorder)

add_executable(cyber_recorder
    player/player.cc
    player/play_task.cc
    player/play_task_buffer.cc
    player/play_task_consumer.cc
    player/play_task_producer.cc
    info.cc
    main.cc
    recorder.cc
    recoverer.cc
    spliter.cc
    )

target_link_libraries(cyber_recorder
    pthread
    ${gflags_LIBRARIES}
    cyber::proto
    cyber::record_reader
    cyber::record_viewer
    cyber::record_writer
    cyber::init
    cyber::component_base
    cyber::cyber_core
    cyber::blocker_manager
    cyber::endpoint
    )

install(TARGETS cyber_recorder
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin
        INCLUDES DESTINATION .
        )

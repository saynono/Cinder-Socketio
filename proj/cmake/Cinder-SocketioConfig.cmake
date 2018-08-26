
if( NOT TARGET Cinder-Socketio )

# This should be done dynamically not hardcoded!!
#	set(BOOST_ROOT "/usr/local/Cellar/boost/1.67.0_1")

	find_package(Boost 1.54.0 REQUIRED system)
	INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS})
	LINK_DIRECTORIES(${Boost_LIBRARY_DIRS})

	get_filename_component( SOCKETIO_SOURCE_PATH "${CMAKE_CURRENT_LIST_DIR}/../../src" ABSOLUTE )
	get_filename_component( SOCKETIO_ROOT "${CMAKE_CURRENT_LIST_DIR}/../../" ABSOLUTE )

	MESSAGE( STATUS "ADDDING SOCKET.IO LIBRARY | " ${SOCKETIO_ROOT} )

	include(${SOCKETIO_SOURCE_PATH}/socket.io-client-cpp/CMakeLists.txt)

	list( APPEND SOCKETIO_SOURCE_PATH
		${SOCKETIO_SOURCE_PATH}/socket.io-client-cpp/src/sio_client.cpp 
		${SOCKETIO_SOURCE_PATH}/socket.io-client-cpp/src/sio_socket.cpp 
		${SOCKETIO_SOURCE_PATH}/socket.io-client-cpp/src/internal/sio_client_impl.cpp
		${SOCKETIO_SOURCE_PATH}/socket.io-client-cpp/src/internal/sio_packet.cpp
	)

	list( APPEND SOCKETIO_INCLUDE_PATH
		"${SOCKETIO_ROOT}/src/socket.io-client-cpp/lib/websocketpp/"
		"${SOCKETIO_ROOT}/src/socket.io-client-cpp/lib/rapidjson/include/"
	)

	add_library( Cinder-Socketio ${SOCKETIO_SOURCE_PATH} )

	if( NOT TARGET cinder )
		    include( "${CINDER_PATH}/proj/cmake/configure.cmake" )
		    find_package( cinder REQUIRED PATHS
		        "${CINDER_PATH}/${CINDER_LIB_DIRECTORY}"
		        "$ENV{CINDER_PATH}/${CINDER_LIB_DIRECTORY}" )
	endif()
	target_include_directories( Cinder-Socketio PUBLIC "${SOCKETIO_INCLUDE_PATH}" )
	target_link_libraries( Cinder-Socketio PRIVATE cinder sioclient )

endif()

# generated from catkin/cmake/template/pkgConfig.cmake.in

# append elements to a list and remove existing duplicates from the list
# copied from catkin/cmake/list_append_deduplicate.cmake to keep pkgConfig
# self contained
macro(_list_append_deduplicate listname)
  if(NOT "${ARGN}" STREQUAL "")
    if(${listname})
      list(REMOVE_ITEM ${listname} ${ARGN})
    endif()
    list(APPEND ${listname} ${ARGN})
  endif()
endmacro()

# append elements to a list if they are not already in the list
# copied from catkin/cmake/list_append_unique.cmake to keep pkgConfig
# self contained
macro(_list_append_unique listname)
  foreach(_item ${ARGN})
    list(FIND ${listname} ${_item} _index)
    if(_index EQUAL -1)
      list(APPEND ${listname} ${_item})
    endif()
  endforeach()
endmacro()

# pack a list of libraries with optional build configuration keywords
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_pack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  set(_argn ${ARGN})
  list(LENGTH _argn _count)
  set(_index 0)
  while(${_index} LESS ${_count})
    list(GET _argn ${_index} lib)
    if("${lib}" MATCHES "^(debug|optimized|general)$")
      math(EXPR _index "${_index} + 1")
      if(${_index} EQUAL ${_count})
        message(FATAL_ERROR "_pack_libraries_with_build_configuration() the list of libraries '${ARGN}' ends with '${lib}' which is a build configuration keyword and must be followed by a library")
      endif()
      list(GET _argn ${_index} library)
      list(APPEND ${VAR} "${lib}${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}${library}")
    else()
      list(APPEND ${VAR} "${lib}")
    endif()
    math(EXPR _index "${_index} + 1")
  endwhile()
endmacro()

# unpack a list of libraries with optional build configuration keyword prefixes
# copied from catkin/cmake/catkin_libraries.cmake to keep pkgConfig
# self contained
macro(_unpack_libraries_with_build_configuration VAR)
  set(${VAR} "")
  foreach(lib ${ARGN})
    string(REGEX REPLACE "^(debug|optimized|general)${CATKIN_BUILD_CONFIGURATION_KEYWORD_SEPARATOR}(.+)$" "\\1;\\2" lib "${lib}")
    list(APPEND ${VAR} "${lib}")
  endforeach()
endmacro()


if(person_tracking_CONFIG_INCLUDED)
  return()
endif()
set(person_tracking_CONFIG_INCLUDED TRUE)

# set variables for source/devel/install prefixes
if("FALSE" STREQUAL "TRUE")
  set(person_tracking_SOURCE_PREFIX /home/pablocano/Proyecto-moviles/catkin_ws/src/person_tracking_ros)
  set(person_tracking_DEVEL_PREFIX /home/pablocano/Proyecto-moviles/catkin_ws/devel)
  set(person_tracking_INSTALL_PREFIX "")
  set(person_tracking_PREFIX ${person_tracking_DEVEL_PREFIX})
else()
  set(person_tracking_SOURCE_PREFIX "")
  set(person_tracking_DEVEL_PREFIX "")
  set(person_tracking_INSTALL_PREFIX /home/pablocano/Proyecto-moviles/catkin_ws/install)
  set(person_tracking_PREFIX ${person_tracking_INSTALL_PREFIX})
endif()

# warn when using a deprecated package
if(NOT "" STREQUAL "")
  set(_msg "WARNING: package 'person_tracking' is deprecated")
  # append custom deprecation text if available
  if(NOT "" STREQUAL "TRUE")
    set(_msg "${_msg} ()")
  endif()
  message("${_msg}")
endif()

# flag project as catkin-based to distinguish if a find_package()-ed project is a catkin project
set(person_tracking_FOUND_CATKIN_PROJECT TRUE)

if(NOT "include " STREQUAL " ")
  set(person_tracking_INCLUDE_DIRS "")
  set(_include_dirs "include")
  if(NOT " " STREQUAL " ")
    set(_report "Check the issue tracker '' and consider creating a ticket if the problem has not been reported yet.")
  elseif(NOT " " STREQUAL " ")
    set(_report "Check the website '' for information and consider reporting the problem.")
  else()
    set(_report "Report the problem to the maintainer 'kl <kl@todo.todo>' and request to fix the problem.")
  endif()
  foreach(idir ${_include_dirs})
    if(IS_ABSOLUTE ${idir} AND IS_DIRECTORY ${idir})
      set(include ${idir})
    elseif("${idir} " STREQUAL "include ")
      get_filename_component(include "${person_tracking_DIR}/../../../include" ABSOLUTE)
      if(NOT IS_DIRECTORY ${include})
        message(FATAL_ERROR "Project 'person_tracking' specifies '${idir}' as an include dir, which is not found.  It does not exist in '${include}'.  ${_report}")
      endif()
    else()
      message(FATAL_ERROR "Project 'person_tracking' specifies '${idir}' as an include dir, which is not found.  It does neither exist as an absolute directory nor in '\${prefix}/${idir}'.  ${_report}")
    endif()
    _list_append_unique(person_tracking_INCLUDE_DIRS ${include})
  endforeach()
endif()

set(libraries "")
foreach(library ${libraries})
  # keep build configuration keywords, target names and absolute libraries as-is
  if("${library}" MATCHES "^(debug|optimized|general)$")
    list(APPEND person_tracking_LIBRARIES ${library})
  elseif(${library} MATCHES "^-l")
    list(APPEND person_tracking_LIBRARIES ${library})
  elseif(${library} MATCHES "^-")
    # This is a linker flag/option (like -pthread)
    # There's no standard variable for these, so create an interface library to hold it
    if(NOT person_tracking_NUM_DUMMY_TARGETS)
      set(person_tracking_NUM_DUMMY_TARGETS 0)
    endif()
    # Make sure the target name is unique
    set(interface_target_name "catkin::person_tracking::wrapped-linker-option${person_tracking_NUM_DUMMY_TARGETS}")
    while(TARGET "${interface_target_name}")
      math(EXPR person_tracking_NUM_DUMMY_TARGETS "${person_tracking_NUM_DUMMY_TARGETS}+1")
      set(interface_target_name "catkin::person_tracking::wrapped-linker-option${person_tracking_NUM_DUMMY_TARGETS}")
    endwhile()
    add_library("${interface_target_name}" INTERFACE IMPORTED)
    if("${CMAKE_VERSION}" VERSION_LESS "3.13.0")
      set_property(
        TARGET
        "${interface_target_name}"
        APPEND PROPERTY
        INTERFACE_LINK_LIBRARIES "${library}")
    else()
      target_link_options("${interface_target_name}" INTERFACE "${library}")
    endif()
    list(APPEND person_tracking_LIBRARIES "${interface_target_name}")
  elseif(TARGET ${library})
    list(APPEND person_tracking_LIBRARIES ${library})
  elseif(IS_ABSOLUTE ${library})
    list(APPEND person_tracking_LIBRARIES ${library})
  else()
    set(lib_path "")
    set(lib "${library}-NOTFOUND")
    # since the path where the library is found is returned we have to iterate over the paths manually
    foreach(path /home/pablocano/Proyecto-moviles/catkin_ws/install/lib;/home/pablocano/Proyecto-moviles/catkin_ws/devel/lib;/root/tb2_ws/devel_isolated/yujin_ocs/lib;/root/tb2_ws/devel_isolated/yocs_waypoints_navi/lib;/root/tb2_ws/devel_isolated/yocs_waypoint_provider/lib;/root/tb2_ws/devel_isolated/yocs_virtual_sensor/lib;/root/tb2_ws/devel_isolated/kobuki_qtestsuite/lib;/root/tb2_ws/devel_isolated/kobuki_testsuite/lib;/root/tb2_ws/devel_isolated/kobuki_node/lib;/root/tb2_ws/devel_isolated/yocs_velocity_smoother/lib;/root/tb2_ws/devel_isolated/yocs_safety_controller/lib;/root/tb2_ws/devel_isolated/yocs_rapps/lib;/root/tb2_ws/devel_isolated/yocs_navigator/lib;/root/tb2_ws/devel_isolated/yocs_navi_toolkit/lib;/root/tb2_ws/devel_isolated/yocs_joyop/lib;/root/tb2_ws/devel_isolated/yocs_ar_pair_tracking/lib;/root/tb2_ws/devel_isolated/yocs_msgs/lib;/root/tb2_ws/devel_isolated/yocs_diff_drive_pose_controller/lib;/root/tb2_ws/devel_isolated/yocs_ar_marker_tracking/lib;/root/tb2_ws/devel_isolated/yocs_math_toolkit/lib;/root/tb2_ws/devel_isolated/yocs_localization_manager/lib;/root/tb2_ws/devel_isolated/yocs_keyop/lib;/root/tb2_ws/devel_isolated/kobuki_safety_controller/lib;/root/tb2_ws/devel_isolated/kobuki_random_walker/lib;/root/tb2_ws/devel_isolated/kobuki_controller_tutorial/lib;/root/tb2_ws/devel_isolated/yocs_controllers/lib;/root/tb2_ws/devel_isolated/yocs_cmd_vel_mux/lib;/root/tb2_ws/devel_isolated/yocs_ar_pair_approach/lib;/root/tb2_ws/devel_isolated/turtlebot_teleop/lib;/root/tb2_ws/devel_isolated/turtlebot_stdr/lib;/root/tb2_ws/devel_isolated/turtlebot_stage/lib;/root/tb2_ws/devel_isolated/turtlebot_simulator/lib;/root/tb2_ws/devel_isolated/turtlebot_rviz_launchers/lib;/root/tb2_ws/devel_isolated/turtlebot_rapps/lib;/root/tb2_ws/devel_isolated/turtlebot_navigation/lib;/root/tb2_ws/devel_isolated/turtlebot_follower/lib;/root/tb2_ws/devel_isolated/turtlebot_msgs/lib;/root/tb2_ws/devel_isolated/turtlebot_interactive_markers/lib;/root/tb2_ws/devel_isolated/turtlebot_interactions/lib;/root/tb2_ws/devel_isolated/turtlebot_gazebo/lib;/root/tb2_ws/devel_isolated/turtlebot_description/lib;/root/tb2_ws/devel_isolated/turtlebot_dashboard/lib;/root/tb2_ws/devel_isolated/turtlebot_capabilities/lib;/root/tb2_ws/devel_isolated/turtlebot_calibration/lib;/root/tb2_ws/devel_isolated/turtlebot_bringup/lib;/root/tb2_ws/devel_isolated/turtlebot_apps/lib;/root/tb2_ws/devel_isolated/turtlebot_actions/lib;/root/tb2_ws/devel_isolated/turtlebot/lib;/root/tb2_ws/devel_isolated/kobuki_driver/lib;/root/tb2_ws/devel_isolated/kobuki_auto_docking/lib;/root/tb2_ws/devel_isolated/kobuki_dock_drive/lib;/root/tb2_ws/devel_isolated/ecl_statistics/lib;/root/tb2_ws/devel_isolated/ecl_mobile_robot/lib;/root/tb2_ws/devel_isolated/ecl_core_apps/lib;/root/tb2_ws/devel_isolated/ecl_geometry/lib;/root/tb2_ws/devel_isolated/ecl_linear_algebra/lib;/root/tb2_ws/devel_isolated/slam_gmapping/lib;/root/tb2_ws/devel_isolated/kobuki_rviz_launchers/lib;/root/tb2_ws/devel_isolated/kobuki_rapps/lib;/root/tb2_ws/devel_isolated/kobuki_keyop/lib;/root/tb2_ws/devel_isolated/kobuki_gazebo_plugins/lib;/root/tb2_ws/devel_isolated/kobuki_dashboard/lib;/root/tb2_ws/devel_isolated/kobuki_bumper2pc/lib;/root/tb2_ws/devel_isolated/kobuki_msgs/lib;/root/tb2_ws/devel_isolated/kobuki_gazebo/lib;/root/tb2_ws/devel_isolated/kobuki_ftdi/lib;/root/tb2_ws/devel_isolated/kobuki_desktop/lib;/root/tb2_ws/devel_isolated/kobuki_description/lib;/root/tb2_ws/devel_isolated/kobuki_core/lib;/root/tb2_ws/devel_isolated/kobuki_capabilities/lib;/root/tb2_ws/devel_isolated/kobuki/lib;/root/tb2_ws/devel_isolated/gmapping/lib;/root/tb2_ws/devel_isolated/ecl_streams/lib;/root/tb2_ws/devel_isolated/ecl_sigslots/lib;/root/tb2_ws/devel_isolated/ecl_devices/lib;/root/tb2_ws/devel_isolated/ecl_threads/lib;/root/tb2_ws/devel_isolated/ecl_containers/lib;/root/tb2_ws/devel_isolated/ecl_utilities/lib;/root/tb2_ws/devel_isolated/ecl_math/lib;/root/tb2_ws/devel_isolated/ecl_formatters/lib;/root/tb2_ws/devel_isolated/ecl_converters/lib;/root/tb2_ws/devel_isolated/ecl_concepts/lib;/root/tb2_ws/devel_isolated/ecl_type_traits/lib;/root/tb2_ws/devel_isolated/ecl_tools/lib;/root/tb2_ws/devel_isolated/ecl_ipc/lib;/root/tb2_ws/devel_isolated/ecl_time/lib;/root/tb2_ws/devel_isolated/ecl_time_lite/lib;/root/tb2_ws/devel_isolated/ecl_sigslots_lite/lib;/root/tb2_ws/devel_isolated/ecl_navigation/lib;/root/tb2_ws/devel_isolated/ecl_mpl/lib;/root/tb2_ws/devel_isolated/ecl_lite/lib;/root/tb2_ws/devel_isolated/ecl_io/lib;/root/tb2_ws/devel_isolated/ecl_filesystem/lib;/root/tb2_ws/devel_isolated/ecl_exceptions/lib;/root/tb2_ws/devel_isolated/ecl_errors/lib;/root/tb2_ws/devel_isolated/ecl_eigen/lib;/root/tb2_ws/devel_isolated/ecl_converters_lite/lib;/root/tb2_ws/devel_isolated/ecl_console/lib;/root/tb2_ws/devel_isolated/ecl_config/lib;/root/tb2_ws/devel_isolated/ecl_command_line/lib;/root/tb2_ws/devel_isolated/ecl_build/lib;/root/tb2_ws/devel_isolated/ecl_license/lib;/root/tb2_ws/devel_isolated/ecl_core/lib;/root/tb2_ws/devel_isolated/depthimage_to_laserscan/lib;/root/tb2_ws/devel_isolated/ddynamic_reconfigure/lib;/root/tb2_ws/devel_isolated/ar_track_alvar_msgs/lib;/opt/ros/noetic/lib)
      find_library(lib ${library}
        PATHS ${path}
        NO_DEFAULT_PATH NO_CMAKE_FIND_ROOT_PATH)
      if(lib)
        set(lib_path ${path})
        break()
      endif()
    endforeach()
    if(lib)
      _list_append_unique(person_tracking_LIBRARY_DIRS ${lib_path})
      list(APPEND person_tracking_LIBRARIES ${lib})
    else()
      # as a fall back for non-catkin libraries try to search globally
      find_library(lib ${library})
      if(NOT lib)
        message(FATAL_ERROR "Project '${PROJECT_NAME}' tried to find library '${library}'.  The library is neither a target nor built/installed properly.  Did you compile project 'person_tracking'?  Did you find_package() it before the subdirectory containing its code is included?")
      endif()
      list(APPEND person_tracking_LIBRARIES ${lib})
    endif()
  endif()
endforeach()

set(person_tracking_EXPORTED_TARGETS "person_tracking_generate_messages_cpp;person_tracking_generate_messages_eus;person_tracking_generate_messages_lisp;person_tracking_generate_messages_nodejs;person_tracking_generate_messages_py")
# create dummy targets for exported code generation targets to make life of users easier
foreach(t ${person_tracking_EXPORTED_TARGETS})
  if(NOT TARGET ${t})
    add_custom_target(${t})
  endif()
endforeach()

set(depends "")
foreach(depend ${depends})
  string(REPLACE " " ";" depend_list ${depend})
  # the package name of the dependency must be kept in a unique variable so that it is not overwritten in recursive calls
  list(GET depend_list 0 person_tracking_dep)
  list(LENGTH depend_list count)
  if(${count} EQUAL 1)
    # simple dependencies must only be find_package()-ed once
    if(NOT ${person_tracking_dep}_FOUND)
      find_package(${person_tracking_dep} REQUIRED NO_MODULE)
    endif()
  else()
    # dependencies with components must be find_package()-ed again
    list(REMOVE_AT depend_list 0)
    find_package(${person_tracking_dep} REQUIRED NO_MODULE ${depend_list})
  endif()
  _list_append_unique(person_tracking_INCLUDE_DIRS ${${person_tracking_dep}_INCLUDE_DIRS})

  # merge build configuration keywords with library names to correctly deduplicate
  _pack_libraries_with_build_configuration(person_tracking_LIBRARIES ${person_tracking_LIBRARIES})
  _pack_libraries_with_build_configuration(_libraries ${${person_tracking_dep}_LIBRARIES})
  _list_append_deduplicate(person_tracking_LIBRARIES ${_libraries})
  # undo build configuration keyword merging after deduplication
  _unpack_libraries_with_build_configuration(person_tracking_LIBRARIES ${person_tracking_LIBRARIES})

  _list_append_unique(person_tracking_LIBRARY_DIRS ${${person_tracking_dep}_LIBRARY_DIRS})
  _list_append_deduplicate(person_tracking_EXPORTED_TARGETS ${${person_tracking_dep}_EXPORTED_TARGETS})
endforeach()

set(pkg_cfg_extras "person_tracking-msg-extras.cmake")
foreach(extra ${pkg_cfg_extras})
  if(NOT IS_ABSOLUTE ${extra})
    set(extra ${person_tracking_DIR}/${extra})
  endif()
  include(${extra})
endforeach()

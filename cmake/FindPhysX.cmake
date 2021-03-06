# Locate the PhysX SDK
#
# This module defines
#  PhysX_FOUND, if false, do not try to link to PhysX
#  PhysX_LIBRARIES
#  PhysX_INCLUDE_DIR
#
# To control the finding you can specify the following entries;
#  PhysX_LIBRARY_DIR
#  PhysX_PROFILE

FIND_PATH(PhysX_INCLUDE_DIR PxPhysicsAPI.h
  PATH_SUFFIXES include Include
  PATHS
  ${PHYSX_HOME}
  $ENV{PHYSX_HOME}
  ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/dependencies/physx
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw # Fink
  /opt/local # DarwinPorts
  /opt/csw # Blastwave
  /opt
)

IF (CMAKE_SIZEOF_VOID_P EQUAL 8)
  SET(LIBFOLDERSUFFIX "64")
  SET(PHYSXPREFIX "_x64")
ELSE()
  SET(LIBFOLDERSUFFIX "32")
ENDIF()

IF (NOT PhysX_LIBRARY_DIR)
  IF (MSVC)
    IF (MSVC_VERSION EQUAL 1700)
      SET(LIBFOLDER vc11win${LIBFOLDERSUFFIX})
    ELSEIF (MSVC_VERSION EQUAL 1800)
      SET(LIBFOLDER vc12win${LIBFOLDERSUFFIX})
    ELSEIF (MSVC_VERSION EQUAL 1900)
      SET(LIBFOLDER vc14win${LIBFOLDERSUFFIX})
    ENDIF()
  ELSEIF (CMAKE_HOST_APPLE)
    SET(LIBFOLDER osx${LIBFOLDERSUFFIX})
  ELSE()
    SET(LIBFOLDER linux${LIBFOLDERSUFFIX})
  ENDIF()

  SET(PhysX_LIBRARY_DIR ${PhysX_INCLUDE_DIR}/../Lib/${LIBFOLDER})
ENDIF()

FIND_LIBRARY(PhysX_LIBRARY_RELEASE PhysX3${PHYSXPREFIX}
  PATH_SUFFIXES lib64 lib Lib/${LIBFOLDERSUFFIX}
  PATHS
  ${PhysX_LIBRARY_DIR}
  ${PhysX_LIBRARY_DIR}/../../Bin/${LIBFOLDER}
  ${PHYSX_HOME}
  $ENV{PHYSX_HOME}
  ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/physx/
  ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/dependencies/physx
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw # Fink
  /opt/local # DarwinPorts
  /opt/csw # Blastwave
  /opt
)
FIND_LIBRARY(PhysX_LIBRARY_PROFILE PhysX3PROFILE${PHYSXPREFIX}
  PATH_SUFFIXES lib lib64 Lib/${LIBFOLDERSUFFIX}
  PATHS
  ${PhysX_LIBRARY_DIR}
  ${PhysX_LIBRARY_DIR}/../../Bin/${LIBFOLDER}
  ${PHYSX_HOME}
  $ENV{PHYSX_HOME}
  ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/physx/
  ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/dependencies/physx
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw # Fink
  /opt/local # DarwinPorts
  /opt/csw # Blastwave
  /opt
)
FIND_LIBRARY(PhysX_LIBRARY_DEBUG PhysX3DEBUG${PHYSXPREFIX}
  PATH_SUFFIXES lib lib64 Lib/${LIBFOLDERSUFFIX}
  PATHS
  ${PhysX_LIBRARY_DIR}
  ${PhysX_LIBRARY_DIR}/../../Bin/${LIBFOLDER}
  ${PHYSX_HOME}
  $ENV{PHYSX_HOME}
  ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/physx/
  ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/dependencies/physx
  ~/Library/Frameworks
  /Library/Frameworks
  /usr/local
  /usr
  /sw # Fink
  /opt/local # DarwinPorts
  /opt/csw # Blastwave
  /opt
)

SET(PhysX_LIBRARIES
  debug ${PhysX_LIBRARY_DEBUG}
)
IF (PhysX_PROFILE)
  SET(PhysX_LIBRARIES ${PhysX_LIBRARIES} optimized ${PhysX_LIBRARY_PROFILE})
ELSE()
  SET(PhysX_LIBRARIES ${PhysX_LIBRARIES} optimized ${PhysX_LIBRARY_RELEASE})
ENDIF()

SET(NECESSARY_COMPONENTS "")
FOREACH(component ${PhysX_FIND_COMPONENTS})
  FIND_LIBRARY(PhysX_LIBRARY_COMPONENT_${component}_DEBUG PhysX3${component}DEBUG${PHYSXPREFIX} PhysX3${component}DEBUG PhysX${component}DEBUG ${component}DEBUG
    PATH_SUFFIXES lib lib64 Lib/${LIBFOLDERSUFFIX}
    PATHS
    ${PhysX_LIBRARY_DIR}
    ${PhysX_LIBRARY_DIR}/../../Bin/${LIBFOLDER}
    ${PHYSX_HOME}
    $ENV{PHYSX_HOME}
    ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/physx/
    ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/dependencies/physx
    ~/Library/Frameworks
    /Library/Frameworks
    /usr/local
    /usr
    /sw # Fink
    /opt/local # DarwinPorts
    /opt/csw # Blastwave
    /opt
  )
  IF (PhysX_LIBRARY_COMPONENT_${component}_DEBUG)
    SET(PhysX_LIBRARIES
      ${PhysX_LIBRARIES}
      debug "${PhysX_LIBRARY_COMPONENT_${component}_DEBUG}"
    )
  ENDIF()

  FIND_LIBRARY(PhysX_LIBRARY_COMPONENT_${component}_PROFILE PhysX3${component}PROFILE${PHYSXPREFIX} PhysX3${component}PROFILE PhysX${component}PROFILE ${component}PROFILE
    PATH_SUFFIXES lib lib64 Lib/${LIBFOLDERSUFFIX}
    PATHS
    ${PhysX_LIBRARY_DIR}
    ${PhysX_LIBRARY_DIR}/../../Bin/${LIBFOLDER}
    ${PHYSX_HOME}
    $ENV{PHYSX_HOME}
    ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/physx/
    ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/dependencies/physx
    ~/Library/Frameworks
    /Library/Frameworks
    /usr/local
    /usr
    /sw # Fink
    /opt/local # DarwinPorts
    /opt/csw # Blastwave
    /opt
  )

  FIND_LIBRARY(PhysX_LIBRARY_COMPONENT_${component}_RELEASE PhysX3${component}${PHYSXPREFIX} PhysX3${component} PhysX${component} ${component}
    PATH_SUFFIXES lib lib64 Lib/${LIBFOLDERSUFFIX}
    PATHS
    ${PhysX_LIBRARY_DIR}
    ${PHYSX_HOME}
    $ENV{PHYSX_HOME}
    ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/physx/
    ${CMAKE_SOURCE_DIR}/../Intrinsic_Dependencies/dependencies/physx
    ~/Library/Frameworks
    /Library/Frameworks
    /usr/local
    /usr
    /sw # Fink
    /opt/local # DarwinPorts
    /opt/csw # Blastwave
    /opt
  )

  MARK_AS_ADVANCED(PhysX_LIBRARY_COMPONENT_${component}_DEBUG PhysX_LIBRARY_COMPONENT_${component}_PROFILE PhysX_LIBRARY_COMPONENT_${component}_RELEASE)
  
  IF (PhysX_PROFILE)
    SET(TARGET "PhysX_LIBRARY_COMPONENT_${component}_PROFILE")
  ELSE()
    SET(TARGET "PhysX_LIBRARY_COMPONENT_${component}_RELEASE")
  ENDIF()

  IF (${TARGET})
    SET(PhysX_LIBRARIES
      ${PhysX_LIBRARIES}
      optimized "${${TARGET}}"
    )
  ENDIF()

  SET(NECESSARY_COMPONENTS
    ${NECESSARY_COMPONENTS}
    PhysX_LIBRARY_COMPONENT_${component}_DEBUG ${TARGET}
  )
ENDFOREACH()

INCLUDE(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(PhysX  DEFAULT_MSG  PhysX_INCLUDE_DIR PhysX_LIBRARY_DEBUG PhysX_LIBRARY_RELEASE ${NECESSARY_COMPONENTS})

MARK_AS_ADVANCED(PhysX_INCLUDE_DIR PhysX_LIBRARY_DIR PhysX_LIBRARY_DEBUG PhysX_LIBRARY_RELEASE PhysX_LIBRARY_PROFILE)

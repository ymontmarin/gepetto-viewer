MACRO(ADD_OSGQT_DEPENDENCY)
  IF(${OPENSCENEGRAPH_VERSION} VERSION_GREATER "3.5.5")
    IF(NOT DEFINED PROJECT_USE_QT4)
      SET(PROJECT_USE_QT4 FALSE CACHE BOOL "Use Qt4 instead of Qt5")
    ENDIF(NOT DEFINED PROJECT_USE_QT4)
    IF(PROJECT_USE_QT4)
      SET(OSGQT_DEPENDENCY openscenegraph-osgQt)
    ELSE(PROJECT_USE_QT4)
      SET(OSGQT_DEPENDENCY openscenegraph-osgQt5)
    ENDIF(PROJECT_USE_QT4)
    ADD_REQUIRED_DEPENDENCY(${OSGQT_DEPENDENCY})
  ELSE()
    SET(OSGQT_DEPENDENCY openscenegraph-osgQt)
    ADD_REQUIRED_DEPENDENCY(${OSGQT_DEPENDENCY})

    IF(NOT DEFINED PROJECT_USE_QT4)
      IF(EXISTS "${OPENSCENEGRAPH_OSGQT_INCLUDEDIR}/osgQt/Version")
        FILE(READ "${OPENSCENEGRAPH_OSGQT_INCLUDEDIR}/osgQt/Version"
          osgqt_version_content
          LIMIT 500)
        STRING(FIND ${osgqt_version_content} "#define OSGQT_QT_VERSION 4" osgqt_qt_version4_idx)
        STRING(FIND ${osgqt_version_content} "#define OSGQT_QT_VERSION 5" osgqt_qt_version5_idx)
        IF(osgqt_qt_version4_idx EQUAL -1 AND osgqt_qt_version5_idx EQUAL -1)
        ELSEIF(osgqt_qt_version4_idx EQUAL -1 )
          # QT5 only
          SET(PROJECT_USE_QT4 FALSE CACHE BOOL "Use Qt4 instead of Qt5")
        ELSEIF(osgqt_qt_version5_idx EQUAL -1 )
          # QT4 only
          SET(PROJECT_USE_QT4 TRUE CACHE BOOL "Use Qt4 instead of Qt5")
        ELSE()
          # Both found.
          MESSAGE(FATAL_ERROR "Could not compute Qt version. Please set PROJECT_USE_QT4 variable manually")
        ENDIF()
      ELSE()
        # QT4 only
        SET(PROJECT_USE_QT4 TRUE CACHE BOOL "Use Qt4 instead of Qt5")
      ENDIF()
    ENDIF(NOT DEFINED PROJECT_USE_QT4)
  ENDIF()
ENDMACRO(ADD_OSGQT_DEPENDENCY)

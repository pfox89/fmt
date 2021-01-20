# Try to find IAR C compiler for ARM

cmake_policy(SET CMP0011 NEW)
cmake_policy(SET CMP0053 NEW)

file(TO_CMAKE_PATH "$ENV{ProgramFiles}" _PROGRAM_FILES)
file(TO_CMAKE_PATH "$ENV{ProgramFiles\(x86\)}" _PROGRAM_FILES_X86)

file(GLOB _IAR_PATHS "${_PROGRAM_FILES}/IAR Systems/Embedded Workbench */" )
file(GLOB _IAR_X86_PATHS "${_PROGRAM_FILES_X86}/IAR Systems/Embedded Workbench *" )

find_path(EWARM_PATH bin/iccarm.exe
  HINTS "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0\\EWARM;InstallPath]"
        "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0;LastInstallPath]"
  PATH_SUFFIXES arm common
  )

find_program(IAR_ARM_C_COMPILER iccarm
  HINTS ${EWARM_PATH} 
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0\\EWARM;InstallPath]"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0;LastInstallPath]"
  PATHS ${_IAR_PATHS} ${_IAR_X86_PATHS}
  PATH_SUFFIXES bin
  DOC "IAR C Compiler for ARM"
  )

  
  find_program(IAR_CSPYBAT 
    NAMES CSpyBat cspybat
    HINTS ${EWARM_PATH} 
    "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0\\EWARM;InstallPath]"
    "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0;LastInstallPath]"
    PATHS ${_IAR_PATHS} ${_IAR_X86_PATHS}
    PATH_SUFFIXES arm/bin common/bin
    DOC "IAR Batch-mode debugger"
  )

  find_path(IAR_ARM_DEBUG_CONFIG_DIR ARM/Cortex-M4.ddf
    HINTS ${EWARM_PATH} 
        "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0\\EWARM;InstallPath]"
        "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\IAR Systems\\Embedded Workbench\\5.0;LastInstallPath]"
    PATHS ${_IAR_PATHS} ${_IAR_X86_PATHS}
    PATH_SUFFIXES config/debugger
  )

set(CMAKE_FIND_LIBRARY_PREFIXES "")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll;so")

find_program(IAR_ARM_ASM_COMPILER iasmarm
  HINTS ${EWARM_PATH}
  PATH_SUFFIXES bin
  DOC "IAR ASM Compiler for ARM"
  )

find_program(IAR_ELFTOOL ielftool
  HINTS ${EWARM_PATH}
  PATH_SUFFIXES bin
  DOC "IAR ELF Tool"
  )

find_program(IAR_ARCHIVE iarchive
  HINTS ${EWARM_PATH}
  PATH_SUFFIXES bin
  DOC "IAR Archive Tool"
  )

find_program(IAR_ILINK ilinkarm
  HINTS ${EWARM_PATH}
  PATH_SUFFIXES bin
  DOC "IAR Linker"
)

find_file(IAR_DLIB_CONFIG DLib_Config_Normal.h
  HINTS ${EWARM_PATH}
  PATH_SUFFIXES inc/c
  DOC "DLIB Config file"
  )


  find_library(IAR_ARMPROC armproc
    HINTS ${EWARM_PATH}
    PATH_SUFFIXES bin
    DOC "IAR ARM Processor simulator plugin"
  )

  find_library(IAR_ARMSIM armsim2
    HINTS ${EWARM_PATH}
    PATH_SUFFIXES bin
    DOC "IAR ARM simulator plugin"
  )

  find_library(IAR_ARMBAT armbat
    HINTS ${EWARM_PATH}
    PATH_SUFFIXES bin
    DOC "IAR ARM batch plugin"
  )

  unset(CMAKE_FIND_LIBRARY_PREFIXES)
  unset(CMAKE_FIND_LIBRARY_SUFFIXES)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(IAR
	DEFAULT_MSG
  EWARM_PATH
  IAR_ARM_DEBUG_CONFIG_DIR
	IAR_ARM_C_COMPILER
  IAR_ARM_ASM_COMPILER
  IAR_CSPYBAT
  IAR_ARCHIVE
  IAR_ILINK
  IAR_DLIB_CONFIG
  IAR_ELFTOOL
  IAR_ARMPROC
  IAR_ARMSIM
  IAR_ARMBAT
  )

mark_as_advanced(
  EWARM_PATH
  IAR_ARM_DEBUG_CONFIG_DIR
	IAR_ARM_C_COMPILER
  IAR_ARM_ASM_COMPILER
  IAR_CSPYBAT
  IAR_ARCHIVE
  IAR_ILINK
  IAR_DLIB_CONFIG
  IAR_ELFTOOL
  IAR_ARMPROC
  IAR_ARMSIM
  IAR_ARMBAT
  )



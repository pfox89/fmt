list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/support/cmake)

find_package(IAR REQUIRED)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)


set(CMAKE_ASM_COMPILER ${IAR_ARM_ASM_COMPILER} CACHE FILEPATH "Assembler path")
set(CMAKE_C_COMPILER "${IAR_ARM_C_COMPILER}" CACHE FILEPATH "C Compiler path")

set(CPU "Cortex-M4" CACHE STRING "Base CPU type")
set(FPU "VFPv4_sp" CACHE STRING "Floating point support")

if(FPU_OPTIONS)
else()
execute_process(COMMAND ${IAR_ARM_C_COMPILER} --fpu=list
  OUTPUT_VARIABLE FPU_OPTIONS
)

string(FIND ${FPU_OPTIONS} "Supported values for the 'fpu' option:" _fpu_options_start)
string(SUBSTRING ${FPU_OPTIONS} ${_fpu_options_start} -1 FPU_OPTIONS )
string(REPLACE "Supported values for the 'fpu' option:" " " FPU_OPTIONS ${FPU_OPTIONS})
string(STRIP ${FPU_OPTIONS} FPU_OPTIONS)
string(REPLACE "\n " ";" FPU_OPTIONS ${FPU_OPTIONS})

if(FPU_OPTIONS)
  set_property(CACHE FPU PROPERTY STRINGS ${FPU_OPTIONS})
endif()

endif()


set(CPU_FLAGS "--cpu ${CPU} --fpu ${FPU}")

option(RUNTIME_CHECKING "Enable C-RUN Runtime Checking" OFF)

set(CMAKE_ASM_FLAGS_INIT "${CPU_FLAGS}")
set(CMAKE_C_FLAGS_INIT "${CPU_FLAGS} -e --dlib_config full --silent ")
set(CMAKE_C_FLAGS_DEBUG_INIT "-On --debug")
set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "")
set(CMAKE_C_FLAGS_RELEASE_INIT "")
set(CMAKE_C_FLAGS_MINSIZEREL_INIT "")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${CPU_FLAGS} --entry __iar_program_start --vfe --debug_heap ")

set(CMAKE_C_OUTPUT_EXTENSION ".o")


set(CMAKE_CXX_COMPILER "${IAR_ARM_C_COMPILER}" CACHE FILEPATH "C++ Compiler path")
set(CMAKE_CXX_FLAGS_INIT "${CPU_FLAGS} -e --c++ --enable_restrict --dlib_config full --silent ")
set(CMAKE_CXX_FLAGS_DEBUG_INIT "-On --debug ")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "")
set(CMAKE_CXX_FLAGS_RELEASE_INIT "")
set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT "")
set(CMAKE_CXX_OUTPUT_EXTENSION ".o")

add_definitions(-DARM_MATH_CM4)



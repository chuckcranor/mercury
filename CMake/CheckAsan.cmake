set(ASAN_FLAG "-fsanitize=address")
set(ASAN_C_FLAGS "-O1 -g ${ASAN_FLAG} -fsanitize-address-use-after-scope -fno-omit-frame-pointer -fno-optimize-sibling-calls")
set(ASAN_CXX_FLAGS ${ASAN_C_FLAGS})

get_property(ASAN_LANGUAGES GLOBAL PROPERTY ENABLED_LANGUAGES)
foreach(lang ${ASAN_LANGUAGES})
  set(ASAN_${lang}_LANG_ENABLED 1)
endforeach()

if(ASAN_C_LANG_ENABLED)
  include(CheckCCompilerFlag)
  set(CMAKE_REQUIRED_LINK_OPTIONS ${ASAN_FLAG})
  check_c_compiler_flag(${ASAN_FLAG} ASAN_C_FLAG_SUPPORTED)
  if(NOT ASAN_C_FLAG_SUPPORTED)
    message(STATUS "Asan flags are not supported by the C compiler.")
  else()
    if(NOT CMAKE_C_FLAGS_ASAN)
      set(CMAKE_C_FLAGS_ASAN ${ASAN_C_FLAGS} CACHE STRING "Flags used by the C compiler during ASAN builds." FORCE)
    endif()
  endif()
  unset(CMAKE_REQUIRED_LINK_OPTIONS)
endif()

if(ASAN_CXX_LANG_ENABLED)
  include(CheckCXXCompilerFlag)
  set(CMAKE_REQUIRED_LINK_OPTIONS ${ASAN_FLAG})
  check_cxx_compiler_flag(${ASAN_FLAG} ASAN_CXX_FLAG_SUPPORTED)
  if(NOT ASAN_CXX_FLAG_SUPPORTED)
    message(STATUS "Asan flags are not supported by the CXX compiler.")  
  else()
    if(NOT CMAKE_CXX_FLAGS_ASAN)
      set(CMAKE_CXX_FLAGS_ASAN ${ASAN_CXX_FLAGS} CACHE STRING "Flags used by the CXX compiler during ASAN builds." FORCE)
    endif()
  endif()
  unset(CMAKE_REQUIRED_LINK_OPTIONS)
endif()


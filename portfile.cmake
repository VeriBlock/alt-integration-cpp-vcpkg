include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO VeriBlock/alt-integration-cpp
        REF 805370ee90b13b749d90a7e488f46381ac03c88f
        SHA512 9d47b7134362ee6483d57186272a3728ba0dc3e4bc0096bc36b588f96e89a42dc7516a0e2abd2598e5dcf523b5b67ead4c920ac46832e6c020c1cc0f10fb46f2
        HEAD_REF master
)

vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        PREFER_NINJA
        OPTIONS
        -DUBSAN:BOOL=OFF
        -DTSAN:BOOL=OFF
        -DASAN:BOOL=OFF
        -DSHARED:BOOL=OFF
        -DTESTING:BOOL=OFF
        -DWITH_SECP256K1:BOOL=OFF
        -DCMAKE_DEBUG_POSTFIX=d
)

vcpkg_install_cmake()

file(COPY ${CURRENT_PACKAGES_DIR}/debug/lib/cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/)
file(COPY ${CURRENT_PACKAGES_DIR}/lib/cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib/cmake")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib/cmake")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO VeriBlock/alt-integration-cpp
        REF 3832a09648074f3604ee5241fca75d846ec92825
        SHA512 0adacd02bf251706324df555fb60f3d1bcebc01a96bd1f2b0859c820b84ad7497b32458b7aba4d3438f3766232c0fd760ae41c7f99fa2e3605cd31dc52b70161
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

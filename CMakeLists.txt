# Copyright (c) 2026 Silicon Laboratories Inc.
# SPDX-License-Identifier: Apache-2.0

cmake_minimum_required(VERSION 3.25)

set(CMAKE_C_STANDARD 17)
set(CMAKE_CONFIGURATION_TYPES release)

project(crypto C)

set(libcryptosoc_path simplicity_sdk/util/third_party/crypto_ip/libcryptosoc)
set(sxsymcrypt_path   simplicity_sdk/util/third_party/crypto_ip/sxsymcrypt)

set(reproducible_build_options
  -ffile-prefix-map=${CMAKE_SOURCE_DIR}=.
  -ffile-prefix-map=${CMAKE_BINARY_DIR}=.
  -fdebug-prefix-map=${CMAKE_SOURCE_DIR}=.
  -fdebug-prefix-map=${CMAKE_BINARY_DIR}=.
  -frandom-seed=0
)

set(libcryptosoc_sources
  ${libcryptosoc_path}/src/ba414ep_config.c
  ${libcryptosoc_path}/src/ba431_config.c
  ${libcryptosoc_path}/src/cryptodma_internal.c
  ${libcryptosoc_path}/src/cryptolib_types.c
  ${libcryptosoc_path}/src/sx_aes.c
  ${libcryptosoc_path}/src/sx_blk_cipher.c
  ${libcryptosoc_path}/src/sx_dh_alg.c
  ${libcryptosoc_path}/src/sx_ecc_curves.c
  ${libcryptosoc_path}/src/sx_ecc_keygen_alg.c
  ${libcryptosoc_path}/src/sx_ecdsa_alg.c
  ${libcryptosoc_path}/src/sx_hash.c
  ${libcryptosoc_path}/src/sx_math.c
  ${libcryptosoc_path}/src/sx_memcmp.c
  ${libcryptosoc_path}/src/sx_memcpy.c
  ${libcryptosoc_path}/src/sx_primitives.c
  ${libcryptosoc_path}/src/sx_rng.c
  ${libcryptosoc_path}/src/sx_trng.c
  ${libcryptosoc_path}/src/platform/silicon_labs/sli_libcryptosoc.c
)

set(libcryptosoc_includes
  cmake/inc
  ${libcryptosoc_path}/include
  ${libcryptosoc_path}/src
)

add_library(cryptosoc_xg22 STATIC ${libcryptosoc_sources})
add_library(cryptosoc_xg27 STATIC ${libcryptosoc_sources})

target_compile_options(cryptosoc_xg22 PUBLIC ${reproducible_build_options})
target_compile_options(cryptosoc_xg27 PUBLIC ${reproducible_build_options})

target_compile_definitions(cryptosoc_xg22 PUBLIC _SILICON_LABS_32B_SERIES_2_CONFIG_2)
target_compile_definitions(cryptosoc_xg27 PUBLIC _SILICON_LABS_32B_SERIES_2_CONFIG_7)

target_include_directories(cryptosoc_xg22 PRIVATE ${libcryptosoc_includes})
target_include_directories(cryptosoc_xg27 PRIVATE ${libcryptosoc_includes})

add_library(sxsymcrypt STATIC
  ${sxsymcrypt_path}/src/aead.c
  ${sxsymcrypt_path}/src/blkcipher.c
  ${sxsymcrypt_path}/src/channel.c
  ${sxsymcrypt_path}/src/cmac.c
  ${sxsymcrypt_path}/src/cmdma.c
  ${sxsymcrypt_path}/src/cmmask.c
  ${sxsymcrypt_path}/src/hash.c
  ${sxsymcrypt_path}/src/hmac.c
  ${sxsymcrypt_path}/src/interrupts.c
  ${sxsymcrypt_path}/src/keyref.c
  ${sxsymcrypt_path}/src/mac.c
)

target_compile_options(sxsymcrypt PUBLIC ${reproducible_build_options})

target_compile_definitions(sxsymcrypt PRIVATE
  SL_CODE_COMPONENT_AES_COMMON=aes_common
  SL_CODE_COMPONENT_AES_CCM=aes_ccm
  SL_CODE_COMPONENT_AES_GCM=aes_gcm
  SL_CODE_COMPONENT_SXSYMCRYPT=sxsymcrypt
  SL_CODE_CLASS_SECURITY=security
)

target_include_directories(sxsymcrypt PRIVATE
  simplicity_sdk/platform/common/inc
  ${sxsymcrypt_path}/include
)

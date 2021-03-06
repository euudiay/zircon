# Copyright 2017 The Fuchsia Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

LOCAL_DIR := $(GET_LOCAL_DIR)

MODULE := $(LOCAL_DIR)

MODULE_TYPE := userlib

MODULE_NAME := blobfs

COMMON_SRCS := \
    $(LOCAL_DIR)/lz4.cpp \
    $(LOCAL_DIR)/common.cpp \
    $(LOCAL_DIR)/fsck.cpp \

# app main
MODULE_SRCS := \
    $(COMMON_SRCS) \
    $(LOCAL_DIR)/blobfs.cpp \
    $(LOCAL_DIR)/metrics.cpp \
    $(LOCAL_DIR)/writeback.cpp \
    $(LOCAL_DIR)/vnode.cpp \
    $(LOCAL_DIR)/rpc.cpp \

MODULE_STATIC_LIBS := \
    system/ulib/fs \
    system/ulib/fzl \
    system/ulib/async.cpp \
    system/ulib/async \
    system/ulib/async-loop.cpp \
    system/ulib/async-loop \
    system/ulib/block-client \
    system/ulib/digest \
    third_party/ulib/lz4 \
    third_party/ulib/uboringssl \
    system/ulib/trace \
    system/ulib/zx \
    system/ulib/zxcpp \
    system/ulib/fbl \
    system/ulib/sync \

MODULE_LIBS := \
    system/ulib/async.default \
    system/ulib/bitmap \
    system/ulib/c \
    system/ulib/fdio \
    system/ulib/trace-engine \
    system/ulib/zircon \

MODULE_FIDL_LIBS := \
    system/fidl/fuchsia-io \

include make/module.mk

# host blobfs lib

MODULE := $(LOCAL_DIR).hostlib

MODULE_TYPE := hostlib

MODULE_SRCS := \
    $(COMMON_SRCS) \
    $(LOCAL_DIR)/host.cpp \

MODULE_COMPILEFLAGS := \
    -Werror-implicit-function-declaration \
    -Wstrict-prototypes -Wwrite-strings \
    -Isystem/ulib/digest/include \
    -Ithird_party/ulib/lz4/include \
    -Ithird_party/ulib/uboringssl/include \
    -Isystem/ulib/fbl/include \
    -Isystem/ulib/fs/include \
    -Isystem/ulib/fdio/include \
    -Isystem/ulib/bitmap/include \

include make/module.mk

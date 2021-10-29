# Versioning System
SATURN_MAJOR_VERSION = Hurricane
SATURN_RELEASE_VERSION = v1.0
SATURN_BUILD_TYPE ?= UNOFFICIAL
SATURN_BUILD_VARIANT := VANILLA

ifeq ($(WITH_GAPPS), true)
    SATURN_BUILD_VARIANT := GAPPS
    $(call inherit-product, vendor/gapps/common/common-vendor.mk)
endif

# SaturnOS Release
ifeq ($(SATURN_BUILD_TYPE), OFFICIAL)
  OFFICIAL_DEVICES = $(shell cat vendor/saturn/saturn.devices)
  FOUND_DEVICE =  $(filter $(SATURN_BUILD), $(OFFICIAL_DEVICES))
    ifeq ($(FOUND_DEVICE),$(SATURN_BUILD))
      SATURN_BUILD_TYPE := OFFICIAL
    else
      SATURN_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(SATURN_BUILD)")
    endif
endif

# System version
TARGET_PRODUCT_SHORT := $(subst saturn_,,$(SATURN_BUILD_TYPE))

SATURN_DATE_YEAR := $(shell date -u +%Y)
SATURN_DATE_MONTH := $(shell date -u +%m)
SATURN_DATE_DAY := $(shell date -u +%d)
SATURN_DATE_HOUR := $(shell date -u +%H)
SATURN_DATE_MINUTE := $(shell date -u +%M)

SATURN_BUILD_DATE := $(SATURN_DATE_YEAR)$(SATURN_DATE_MONTH)$(SATURN_DATE_DAY)-$(SATURN_DATE_HOUR)$(SATURN_DATE_MINUTE)
SATURN_BUILD_VERSION := $(SATURN_MAJOR_VERSION)-$(SATURN_RELEASE_VERSION)
SATURN_BUILD_FINGERPRINT := SaturnOS/$(SATURN_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(SATURN_BUILD_DATE)
SATURN_VERSION := SaturnOS-$(SATURN_BUILD_VERSION)-$(SATURN_BUILD)-$(SATURN_BUILD_TYPE)-$(SATURN_BUILD_DATE)
SATURN_RELEASE := SaturnOS-$(SATURN_BUILD_VERSION)-$(SATURN_BUILD)-$(SATURN_BUILD_TYPE)-$(SATURN_BUILD_VARIANT)-$(SATURN_BUILD_DATE)

PRODUCT_GENERIC_PROPERTIES += \
  ro.saturn.device=$(SATURN_BUILD) \
  ro.saturn.version=$(SATURN_VERSION) \
  ro.saturn.build.version=$(SATURN_BUILD_VERSION) \
  ro.saturn.build.type=$(SATURN_BUILD_TYPE) \
  ro.saturn.build.variant=$(SATURN_BUILD_VARIANT) \
  ro.saturn.build.date=$(SATURN_BUILD_DATE) \
  ro.saturn.build.fingerprint=$(SATURN_BUILD_FINGERPRINT)

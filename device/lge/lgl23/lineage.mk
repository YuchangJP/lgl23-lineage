# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/lge/lgl23/lgl23.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := lgl23
PRODUCT_NAME := lineage_lgl23
PRODUCT_BRAND := KDDI
PRODUCT_MODEL := LGL23
PRODUCT_MANUFACTURER := LGE

# Fingerprint taken from the LGL23 stock dump (default.prop)
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="z_jp_kdi-user 4.2.2 JDQ39B LGL2310d.1386665260 release-keys"

BUILD_FINGERPRINT := KDDI/z_jp_kdi/zee:4.2.2/JDQ39B/LGL2310d.1386665260:user/release-keys

# LineageOS 15.1 (Android 8.1) for the LG G Flex (KDDI / au) — LGL23

Unofficial bring-up of **LineageOS 15.1 (Android 8.1 Oreo)** for the KDDI/au
LG G Flex **LGL23** (codename `lgl23`, internal name `zee`, board `galbi`,
SoC Qualcomm MSM8974).

Built entirely on **GitHub Actions** (`.github/workflows/lineage.yml`).

## Why this works / what it reuses

LGL23 shares the msm8974 "galbi" platform with the LG G2 / international G Flex.
The [lge-devs](https://github.com/lge-devs) org already publishes the G Flex
device tree, kernel and vendor blobs **including LGL23-specific bits**:

| Piece | Repository | Notes |
|---|---|---|
| G Flex common tree | `lge-devs/android_device_lge_z-common` (`lineage-15.1`) | `BoardConfigCommon.mk`, `zee.mk`, `releasetools/open_bump.py` |
| Kernel (galbi) | `lge-devs/android_kernel_lge_msm8974` (`lineage-15.1`) | contains **`arch/arm/configs/lineageos_lgl23_defconfig`** and **`arch/arm/boot/dts/lge/msm8974-z/msm8974-z-kddi`** |
| Vendor blobs | `lge-devs/proprietary_vendor_lge_zee` (`lineage-15.1`) | `z-common/` + `f340l/` |
| dtbTool | `LineageOS/android_system_tools_dtbtool` | `dtbToolLineage` host tool |
| Base manifest | `LineageOS/android` `lineage-15.1` | |

The kernel defconfig name and the DTS target for LGL23 are already present in
the lge-devs kernel, so this device tree only needs the per-device glue
(`device/lge/lgl23`).

## Layout

```
device/lge/lgl23/                     # device tree (built via local_manifests)
local_manifests/lgl23.xml             # repos added on top of LineageOS 15.1
.github/workflows/lineage.yml         # GitHub Actions build
```

## Building

Push to `main` (or run the workflow manually). The workflow:

1. frees disk space,
2. installs deps + Python 2.7 (Miniconda) + Java 8 (runner `JAVA_HOME_8_X64`),
3. `repo init -u https://github.com/LineageOS/android.git -b lineage-15.1` and
   syncs, adding `local_manifests/lgl23.xml`,
4. copies this device tree into `device/lge/lgl23`,
5. `lunch lineage_lgl23-userdebug && make bacon`,
6. uploads `lineage-15.1-*-UNOFFICIAL-lgl23.zip` (and images) as artifacts.

## Status / caveats

- **Bring-up attempt.** The ROM boots the common msm8974 stack; hardware support
  inherited from z-common.
- **Proprietary blobs** currently come from the **f340l (Korean G Flex)** vendor
  tree as a fallback — LGL23 stock blobs have not been extracted yet. Replacing
  them with blobs from `by-name/system` of the LGL23 dump is the next step
  (au-specific RIL/radio, sensors).
- **Boot image signing:** z-common's `releasetools/mkbootimg.mk` signs
  boot/recovery with **Open Bump** (`open_bump.py`). LGL23's stock aboot
  (`LGL2310d`) is also supported by the legacy `loki` tool.
- **Not expected to work:** ワンセグ (ISDB-T/OneSeg), フルセグ, Felica/おサイフケータイ.
- Bootloader is locked; flashing requires a bump/loki-signed image.

## Sources

- LG G Flex TWRP analysis: `TWRP_LGL23.md` and the LGL23 partition dump.
- lge-devs G Flex trees/kernel/vendor (see table above).
- LGL22 (isai) LineageOS 15.1 build notes:
  https://plaza.rakuten.co.jp/solarisintel/diary/201907250000/

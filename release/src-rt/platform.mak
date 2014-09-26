export LINUXDIR := $(SRCBASE)/linux/linux-2.6

EXTRA_CFLAGS := -DLINUX26 -DCONFIG_BCMWL5 -DDEBUG_NOISY -DDEBUG_RCTEST -pipe -DTTEST

export CONFIG_LINUX26=y
export CONFIG_BCMWL5=y

#export PARALLEL_BUILD :=
export PARALLEL_BUILD := -j`grep -c '^processor' /proc/cpuinfo`

define platformRouterOptions
endef

define platformBusyboxOptions
endef

define platformKernelConfig
# prepare config_base
# prepare prebuilt kernel binary
	@( \
	sed -i "/CONFIG_RGMII_BCM_FA/d" $(1); \
	if [ "$(RGMII_BCM_FA)" = "y" ]; then \
		echo "CONFIG_RGMII_BCM_FA=y" >> $(1); \
	else \
		echo "# CONFIG_RGMII_BCM_FA is not set" >> $(1); \
	fi; \
	if [ "$(BCMNAND)" = "y" ]; then \
		sed -i "/CONFIG_MTD_NFLASH/d" $(1); \
		echo "CONFIG_MTD_NFLASH=y" >>$(1); \
		sed -i "/CONFIG_MTD_NAND/d" $(1); \
		echo "CONFIG_MTD_NAND=y" >>$(1); \
		echo "CONFIG_MTD_NAND_IDS=y" >>$(1); \
		echo "# CONFIG_MTD_NAND_VERIFY_WRITE is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_ECC_SMC is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_MUSEUM_IDS is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_DENALI is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_RICOH is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_DISKONCHIP is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_CAFE is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_NANDSIM is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_PLATFORM is not set" >>$(1); \
		echo "# CONFIG_MTD_NAND_ONENAND is not set" >>$(1); \
		sed -i "/CONFIG_MTD_BRCMNAND/d" $(1); \
		echo "CONFIG_MTD_BRCMNAND=y" >>$(1); \
	fi; \
	if [ "$(ARM)" = "y" ]; then \
		mkdir -p $(SRCBASE)/router/ctf_arm/linux;\
		cp -f $(SRCBASE)/router/ctf_arm/bcm6x/ctf.* $(SRCBASE)/router/ctf_arm/linux/;\
		if [ "$(BCM7)" = "y" ]; then \
			cp -f $(SRCBASE)/../../dhd/src/shared/rtecdc_43602a0.h.in $(SRCBASE)/../../dhd/src/shared/rtecdc_43602a0.h;\
			cp -f $(SRCBASE)/../../dhd/src/shared/rtecdc_43602a1.h.in $(SRCBASE)/../../dhd/src/shared/rtecdc_43602a1.h;\
			if [ "$(ARMCPUSMP)" = "up" ]; then \
				cp -f $(SRCBASE)/router/ctf_arm/bcm7_up/ctf.* $(SRCBASE)/router/ctf_arm/linux/;\
			else \
				if [ "$(DPSTA)" = "y" ]; then \
					cp -f $(SRCBASE)/router/ctf_arm/bcm7_dpsta/ctf.* $(SRCBASE)/router/ctf_arm/linux/;\
					cp -f $(SRCBASE)/router/dpsta/bcm7_3200/dpsta.o $(SRCBASE)/router/dpsta/linux;\
				else \
					cp -f $(SRCBASE)/router/ctf_arm/bcm7/ctf.* $(SRCBASE)/router/ctf_arm/linux/;\
				fi; \
			fi; \
		else \
			if [ "$(ARMCPUSMP)" = "up" ]; then \
				cp -f $(SRCBASE)/router/ctf_arm/bcm6_up/linux/ctf.* $(SRCBASE)/router/ctf_arm/linux/;\
				cp -f $(SRCBASE)/router/ufsd/broadcom_arm_up/ufsd.ko.46_up router/ufsd/broadcom_arm/ufsd.ko; \
			fi; \
			if [ "$(BWDPI)" = "y" ]; then \
				cp -f $(SRCBASE)/router/ctf_arm/bcm6_iqos/ctf.* $(SRCBASE)/router/ctf_arm/linux/;\
			fi; \
		fi; \
	fi; \
	if [ "$(SFPRAM16M)" = "y" ]; then \
		sed -i "/CONFIG_WL_USE_AP/d" $(1); \
		echo "CONFIG_WL_USE_APSTA=y" >>$(1); \
		echo "# CONFIG_WL_USE_AP is not set" >>$(1); \
		echo "# CONFIG_WL_USE_AP_SDSTD is not set" >>$(1); \
		echo "# CONFIG_WL_USE_AP_ONCHIP_G is not set" >>$(1); \
		echo "# CONFIG_WL_USE_APSTA_ONCHIP_G is not set" >>$(1); \
		sed -i "/CONFIG_INET_GRO/d" $(1); \
		echo "# CONFIG_INET_GRO is not set" >> $(1); \
		sed -i "/CONFIG_INET_GSO/d" $(1); \
		echo "# CONFIG_INET_GSO is not set" >> $(1); \
		sed -i "/CONFIG_NET_SCH_HFSC/d" $(1); \
		echo "# CONFIG_NET_SCH_HFSC is not set" >> $(1); \
		sed -i "/CONFIG_NET_SCH_ESFQ/d" $(1); \
		echo "# CONFIG_NET_SCH_ESFQ is not set" >> $(1); \
		sed -i "/CONFIG_NET_SCH_TBF/d" $(1); \
		echo "# CONFIG_NET_SCH_TBF is not set" >> $(1); \
		sed -i "/CONFIG_NLS/d" $(1); \
		echo "# CONFIG_NLS is not set" >>$(1); \
		echo "# CONFIG_NLS_DEFAULT=\"iso8859-1\"">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_437 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_737 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_775 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_850 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_852 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_855 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_857 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_860 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_861 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_862 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_863 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_864 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_865 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_866 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_869 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_936 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_950 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_932 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_949 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_874 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_8 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_1250 is not set">>$(1); \
		echo "# CONFIG_NLS_CODEPAGE_1251 is not set">>$(1); \
		echo "# CONFIG_NLS_ASCII is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_1 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_2 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_3 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_4 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_5 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_6 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_7 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_9 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_13 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_14 is not set">>$(1); \
		echo "# CONFIG_NLS_ISO8859_15 is not set">>$(1); \
		echo "# CONFIG_NLS_KOI8_R is not set">>$(1); \
		echo "# CONFIG_NLS_KOI8_U is not set">>$(1); \
		echo "# CONFIG_NLS_UTF8 is not set">>$(1); \
		sed -i "/CONFIG_USB/d" $(1); \
		echo "# CONFIG_USB_SUPPORT is not set" >> $(1); \
		sed -i "/CONFIG_SCSI/d" $(1); \
		echo "# CONFIG_SCSI is not set" >> $(1); \
		sed -i "/CONFIG_LBD/d" $(1); \
		echo "# CONFIG_LBD is not set" >> $(1); \
		sed -i "/CONFIG_BLK_DEV_SD/d" $(1); \
		sed -i "/CONFIG_BLK_DEV_SR/d" $(1); \
		sed -i "/CONFIG_CHR_DEV_SG/d" $(1); \
		sed -i "/CONFIG_VIDEO/d" $(1); \
		echo "# CONFIG_VIDEO_DEV is not set" >> $(1); \
		sed -i "/CONFIG_V4L_USB_DRIVERS/d" $(1); \
		sed -i "/CONFIG_SOUND/d" $(1); \
		echo "# CONFIG_SOUND is not set" >> $(1); \
		sed -i "/CONFIG_SND/d" $(1); \
		sed -i "/CONFIG_HID/d" $(1); \
		echo "# CONFIG_HID is not set" >> $(1); \
		sed -i "/CONFIG_MMC/d" $(1); \
		echo "# CONFIG_MMC is not set" >> $(1); \
		sed -i "/CONFIG_PARTITION_ADVANCED/d" $(1); \
		echo "# CONFIG_PARTITION_ADVANCED is not set" >> $(1); \
		sed -i "/CONFIG_TRACE_IRQFLAGS_SUPPORT/d" $(1); \
		sed -i "/CONFIG_SYS_SUPPORTS_KGDB/d" $(1); \
		sed -i "/CONFIG_EXT2_FS/d" $(1); \
		echo "# CONFIG_EXT2_FS is not set" >> $(1); \
		sed -i "/CONFIG_EXT3_FS/d" $(1); \
		echo "# CONFIG_EXT3_FS is not set" >> $(1); \
		sed -i "/CONFIG_JBD/d" $(1); \
		echo "# CONFIG_JBD is not set" >> $(1); \
		sed -i "/CONFIG_REISERFS_FS/d" $(1); \
		echo "# CONFIG_REISERFS_FS is not set" >> $(1); \
		sed -i "/CONFIG_FAT_FS/d" $(1); \
		echo "# CONFIG_FAT_FS is not set" >> $(1); \
		sed -i "/CONFIG_VFAT_FS/d" $(1); \
		echo "# CONFIG_VFAT_FS is not set" >> $(1); \
		sed -i "/CONFIG_NFS_FS/d" $(1); \
		echo "# CONFIG_NFS_FS is not set" >> $(1); \
		sed -i "/CONFIG_NFSD/d" $(1); \
		echo "# CONFIG_NFSD is not set" >> $(1); \
		sed -i "/CONFIG_FUSE_FS/d" $(1); \
		echo "# CONFIG_FUSE_FS is not set" >> $(1); \
		sed -i "/CONFIG_CIFS/d" $(1); \
		echo "# CONFIG_CIFS is not set" >> $(1); \
		sed -i "/CONFIG_FAT/d" $(1); \
		sed -i "/CONFIG_INOTIFY/d" $(1); \
		echo "# CONFIG_INOTIFY is not set" >> $(1); \
		sed -i "/CONFIG_DNOTIFY/d" $(1); \
		echo "# CONFIG_DNOTIFY is not set" >> $(1); \
		sed -i "/CONFIG_CRYPTO_BLKCIPHER/d" $(1); \
		sed -i "/CONFIG_CRYPTO_HASH/d" $(1); \
		sed -i "/CONFIG_CRYPTO_MANAGER/d" $(1); \
		echo "# CONFIG_CRYPTO_MANAGER is not set" >> $(1); \
		sed -i "/CONFIG_CRYPTO_HMAC/d" $(1); \
		echo "# CONFIG_CRYPTO_HMAC is not set" >> $(1); \
		sed -i "/CONFIG_CRYPTO_ECB/d" $(1); \
		echo "# CONFIG_CRYPTO_ECB is not set" >> $(1); \
		sed -i "/CONFIG_CRYPTO_CBC/d" $(1); \
		echo "# CONFIG_CRYPTO_CBC is not set" >> $(1); \
	fi; \
	if [ "$(ARM)" = "y" ]; then \
                if [ -d $(SRCBASE)/router/wl_arm/$(BUILD_NAME) ]; then \
                        mkdir $(SRCBASE)/wl/linux ; \
                        cp $(SRCBASE)/router/wl_arm/$(BUILD_NAME)/prebuilt/* $(SRCBASE)/wl/linux ; \
                elif [ -d $(SRCBASE)/router/wl_arm/prebuilt ]; then \
			mkdir $(SRCBASE)/wl/linux ; \
			cp $(SRCBASE)/router/wl_arm/prebuilt/* $(SRCBASE)/wl/linux ; \
		elif [ -d $(SRCBASE)/wl/sysdeps/$(BUILD_NAME) ]; then \
			if [ -d $(SRCBASE)/wl/sysdeps/$(BUILD_NAME)/linux ]; then \
				cp -rf $(SRCBASE)/wl/sysdeps/$(BUILD_NAME)/linux $(SRCBASE)/wl/. ; \
			fi; \
			if [ -d $(SRCBASE)/wl/sysdeps/$(BUILD_NAME)/clm ]; then \
				cp -f $(SRCBASE)/wl/sysdeps/$(BUILD_NAME)/clm/src/wlc_clm_data.c $(SRCBASE)/wl/clm/src/. ; \
			fi; \
		else \
			if [ -d $(SRCBASE)/wl/sysdeps/default/linux ]; then \
				cp -rf $(SRCBASE)/wl/sysdeps/default/linux $(SRCBASE)/wl/. ; \
			fi; \
			if [ -d $(SRCBASE)/wl/sysdeps/default/clm ]; then \
				cp -f $(SRCBASE)/wl/sysdeps/default/clm/src/wlc_clm_data.c $(SRCBASE)/wl/clm/src/. ; \
			fi; \
		fi; \
	else \
		[ -d $(SRCBASE)/wl/sysdeps/default ] && \
			cp -rf $(SRCBASE)/wl/sysdeps/default/* $(SRCBASE)/wl/; \
		[ -d $(SRCBASE)/wl/sysdeps/$(BUILD_NAME) ] && \
			cp -rf $(SRCBASE)/wl/sysdeps/$(BUILD_NAME)/* $(SRCBASE)/wl/; \
	fi; \
	if [ "$(SNMPD)" = "y" ]; then \
		if [ -d $(SRCBASE)/router/net-snmp-5.7.2/asus_mibs/sysdeps/$(BUILD_NAME) ]; then \
			rm -f  $(SRCBASE)/router/net-snmp-5.7.2/mibs/RT-*.txt ; \
			rm -f  $(SRCBASE)/router/net-snmp-5.7.2/mibs/TM-*.txt ; \
			rm -rf $(SRCBASE)/router/net-snmp-5.7.2/agent/mibgroup/asus-mib ; \
			cp -rf $(SRCBASE)/router/net-snmp-5.7.2/asus_mibs/sysdeps/$(BUILD_NAME)/$(BUILD_NAME)-MIB.txt $(SRCBASE)/router/net-snmp-5.7.2/mibs ; \
			cp -rf $(SRCBASE)/router/net-snmp-5.7.2/asus_mibs/sysdeps/$(BUILD_NAME)/asus-mib $(SRCBASE)/router/net-snmp-5.7.2/agent/mibgroup ; \
		fi; \
	fi; \
	)
endef

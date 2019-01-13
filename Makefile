TMP_DIR := tmp
DIST_DIR := dist

ADDON_ID := $(shell python -c "import xml.etree.ElementTree; print(xml.etree.ElementTree.parse('addon.xml').getroot().attrib['id']);")
ADDON_VERSION := $(shell python -c "import xml.etree.ElementTree; print(xml.etree.ElementTree.parse('addon.xml').getroot().attrib['version']);")

package: build-binaries
	rm -rf $(DIST_DIR); \
	rm -rf $(ADDON_ID); \
	mkdir $(ADDON_ID) && \
	rsync -arv --exclude=$(ADDON_ID) * $(ADDON_ID) && \
	mkdir $(DIST_DIR) && \
	zip -r $(DIST_DIR)/$(ADDON_ID)-$(ADDON_VERSION).zip $(ADDON_ID)/* && \
	rm -rf $(ADDON_ID)

build-binaries:
	mkdir $(TMP_DIR) && \
	cd $(TMP_DIR) && \
	git clone git@github.com:chrisxf/kodi-chrome-pilot.git . && \
	make build-linux && \
	mv build/linux-amd64/bin/kodi-chrome-pilot ../bin && \
	rm -rf ../$(TMP_DIR)
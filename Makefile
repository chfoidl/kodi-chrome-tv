ADDON_ID := $(shell python -c "import xml.etree.ElementTree; print(xml.etree.ElementTree.parse('addon.xml').getroot().attrib['id']);")
ADDON_VERSION := $(shell python -c "import xml.etree.ElementTree; print(xml.etree.ElementTree.parse('addon.xml').getroot().attrib['version']);")

package: build-binaries
	mkdir dist; \
	zip dist/$(ADDON_ID)-$(ADDON_VERSION).zip *

build-binaries:
	mkdir tmp && \
	cd tmp && \
	git clone git@github.com:chrisxf/kodi-chrome-pilot.git . && \
	make build-linux && \
	mv build/linux-amd64/bin/kodi-chrome-pilot ../bin && \
	rm -rf ../tmp
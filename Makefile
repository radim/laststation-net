IMAGE_PATH ?=
IMAGE_NAME ?= $(notdir $(IMAGE_PATH))
STUB_PATH = content/snaps/$(basename $(IMAGE_NAME)).md
TARGET_DIR = static/snaps
THUMB_SUFFIX = _thumb

build:
	zola build

deploy:
	rsync --archive --delete public/ petal:~/web/laststation-net/

new_snap: copy_image generate_thumb create_stub

copy_image:
	mkdir -p $(TARGET_DIR)
	cp $(IMAGE_PATH) $(TARGET_DIR)/$(IMAGE_NAME)

generate_thumb:
	gm convert $(TARGET_DIR)/$(IMAGE_NAME) -resize 350x350 -background "#fff" -gravity center -extent 350x350 $(TARGET_DIR)/$(basename $(IMAGE_NAME))$(THUMB_SUFFIX)$(suffix $(IMAGE_NAME))

create_stub:
	mkdir -p $(dir $(STUB_PATH))
	echo "+++\ntitle = \"Your Title\"\ndate = \"$(shell date '+%Y-%m-%d')\"\n[extra]\nphoto = \"/snaps/$(basename $(IMAGE_NAME))$(suffix $(IMAGE_NAME))\"\nthumb = \"/snaps/$(basename $(IMAGE_NAME))$(THUMB_SUFFIX)$(suffix $(IMAGE_NAME))\"\n+++\n\n" > $(STUB_PATH)

.PHONY: all build deploy new_snap

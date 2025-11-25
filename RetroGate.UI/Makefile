# Makefile for generating Dart code from Protocol Buffers
# Usage:
#   make gen           - Generate all proto modules
#   make gen-game      - Generate only game module
#   make gen-config    - Generate only config module
#   make gen-installer - Generate only installer module
#   make gen-shortcut  - Generate only shortcut module
#   make clean         - Remove all generated proto files

# Directories
PROTO_ROOT = ../RetroGate.Protos
PROTO_UI = protos
OUT_DIR = lib/generated

# Protoc configuration
PROTOC = protoc
PROTOC_GEN_DART = --dart_out=grpc:$(OUT_DIR)
PROTO_PATH = --proto_path=$(PROTO_ROOT) --proto_path=$(PROTO_UI)

# Common proto files (dependencies)
GOOGLE_EMPTY = $(PROTO_UI)/google/protobuf/empty.proto

# Game module protos
GAME_PROTOS = \
	$(PROTO_ROOT)/game/proto/v1/game_model.proto \
	$(PROTO_ROOT)/game/proto/v1/game_images_model.proto \
	$(PROTO_ROOT)/game/proto/v1/game_service.proto

# Config module protos
CONFIG_PROTOS = \
	$(PROTO_ROOT)/config/proto/v1/config_model.proto \
	$(PROTO_ROOT)/config/proto/v1/config_service.proto

# Installer module protos
INSTALLER_PROTOS = \
	$(PROTO_ROOT)/installer/proto/v1/installer_event_model.proto \
	$(PROTO_ROOT)/installer/proto/v1/installer_service.proto

# Shortcut module protos
SHORTCUT_PROTOS = \
	$(PROTO_ROOT)/shortcut/proto/v1/shortcut_model.proto \
	$(PROTO_ROOT)/shortcut/proto/v1/shortcut_service.proto

# Targets
.PHONY: gen gen-game gen-config gen-installer gen-shortcut clean help

# Default target
help:
	@echo "Available targets:"
	@echo "  make gen           - Generate all proto modules"
	@echo "  make gen-game      - Generate only game module"
	@echo "  make gen-config    - Generate only config module"
	@echo "  make gen-installer - Generate only installer module"
	@echo "  make gen-shortcut  - Generate only shortcut module"
	@echo "  make clean         - Remove all generated proto files"

# Generate all modules
gen: gen-game gen-config gen-installer gen-shortcut
	@echo "✓ All proto modules generated successfully!"

# Generate game module
gen-game:
	@echo "Generating game module..."
	$(PROTOC) $(PROTOC_GEN_DART) $(PROTO_PATH) $(GAME_PROTOS)
	@echo "✓ Game module generated"

# Generate config module
gen-config:
	@echo "Generating config module..."
	$(PROTOC) $(PROTOC_GEN_DART) $(PROTO_PATH) $(CONFIG_PROTOS)
	@echo "✓ Config module generated"

# Generate installer module
gen-installer:
	@echo "Generating installer module..."
	$(PROTOC) $(PROTOC_GEN_DART) $(PROTO_PATH) $(INSTALLER_PROTOS)
	@echo "✓ Installer module generated"

# Generate shortcut module
gen-shortcut:
	@echo "Generating shortcut module..."
	$(PROTOC) $(PROTOC_GEN_DART) $(PROTO_PATH) $(SHORTCUT_PROTOS)
	@echo "✓ Shortcut module generated"

# Clean generated files
clean:
	@echo "Cleaning generated proto files..."
	@if exist $(OUT_DIR)\game rmdir /s /q $(OUT_DIR)\game
	@if exist $(OUT_DIR)\config rmdir /s /q $(OUT_DIR)\config
	@if exist $(OUT_DIR)\installer rmdir /s /q $(OUT_DIR)\installer
	@if exist $(OUT_DIR)\shortcut rmdir /s /q $(OUT_DIR)\shortcut
	@if exist $(OUT_DIR)\google rmdir /s /q $(OUT_DIR)\google
	@echo "✓ Cleaned"

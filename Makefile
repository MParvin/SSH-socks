RELEASE_DIR := release
APK_SRC     := app/build/outputs/apk/release/app-release-unsigned.apk
APK_DEST    := $(RELEASE_DIR)/app-release.apk

.PHONY: build push

build:
	chmod +x ./gradlew
	./gradlew assembleRelease
	mkdir -p $(RELEASE_DIR)
	cp $(APK_SRC) $(APK_DEST)
	@echo "APK copied to $(APK_DEST)"

push:
	@LAST_TAG=$$(gh release list --limit 1 --json tagName --jq '.[0].tagName' 2>/dev/null || echo ''); \
	if [ -z "$$LAST_TAG" ]; then \
		NEW_TAG="0.0.1"; \
	else \
		MAJOR=$$(echo "$$LAST_TAG" | cut -d. -f1); \
		MINOR=$$(echo "$$LAST_TAG" | cut -d. -f2); \
		PATCH=$$(echo "$$LAST_TAG" | cut -d. -f3); \
		NEW_TAG="$$MAJOR.$$MINOR.$$((PATCH + 1))"; \
	fi; \
	echo "Creating tag $$NEW_TAG..."; \
	git tag "$$NEW_TAG" && git push origin "$$NEW_TAG" && echo "Pushed tag $$NEW_TAG"

.DEFAULT_GOAL := build

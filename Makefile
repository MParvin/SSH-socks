RELEASE_DIR := release
APK_SRC     := app/build/outputs/apk/release/ssh-socks-unsigned.apk
APK_DEST    := $(RELEASE_DIR)/app-release.apk

.PHONY: build push

build:
	chmod +x ./gradlew
	./gradlew assembleRelease
	mkdir -p $(RELEASE_DIR)
	cp $(APK_SRC) $(APK_DEST)
	@echo "APK copied to $(APK_DEST)"

push:
	@REMOTE_TAG=$$(gh release list --limit 1 --json tagName --jq '.[0].tagName' 2>/dev/null || echo ''); \
	LOCAL_TAG=$$(git tag --sort=-version:refname | head -1); \
	if [ -z "$$REMOTE_TAG" ] && [ -z "$$LOCAL_TAG" ]; then \
		NEW_TAG="v0.0.1"; \
	else \
		if [ -z "$$REMOTE_TAG" ]; then LAST_TAG="$$LOCAL_TAG"; \
		elif [ -z "$$LOCAL_TAG" ]; then LAST_TAG="$$REMOTE_TAG"; \
		else \
			LAST_TAG=$$(printf '%s\n' "$$REMOTE_TAG" "$$LOCAL_TAG" | sort -V | tail -1); \
		fi; \
		MAJOR=$$(echo "$$LAST_TAG" | sed 's/^v//' | cut -d. -f1); \
		MINOR=$$(echo "$$LAST_TAG" | sed 's/^v//' | cut -d. -f2); \
		PATCH=$$(echo "$$LAST_TAG" | sed 's/^v//' | cut -d. -f3); \
		NEW_TAG="v$$MAJOR.$$MINOR.$$((PATCH + 1))"; \
	fi; \
	echo "Creating tag $$NEW_TAG..."; \
	git tag "$$NEW_TAG" && git push origin "$$NEW_TAG" && echo "Pushed tag $$NEW_TAG"

.DEFAULT_GOAL := build

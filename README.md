# SSH-socks

An Android application for managing and establishing SSH connections with a shell interface. Store multiple SSH profiles securely and connect to remote servers directly from your Android device.

## Features

- **Multiple SSH profiles** — create, edit, and delete saved connections
- **Password & key-based authentication** — supports both SSH password and private key login
- **Interactive shell** — open a live shell channel and send commands after connecting
- **Encrypted credential storage** — passwords and private keys are encrypted at rest using AES-256-GCM backed by the Android Keystore
- **Local database** — profiles persisted in a Room SQLite database

## Requirements

- Android 8.0 (API 26) or higher
- JDK 11
- Android SDK with `compileSdk 33`

## Building

### With Make

```bash
make
```

The signed (or unsigned) release APK will be placed in the `release/` directory.

### With Gradle directly

```bash
./gradlew assembleRelease
# Output: app/build/outputs/apk/release/app-release-unsigned.apk
```

## Project Structure

```
app/src/main/java/com/example/sshinjector/
├── MainActivity.kt              # Entry point, Navigation host
├── db/
│   ├── AppDatabase.kt           # Room database definition
│   └── SSHProfileDao.kt         # DAO for profile CRUD operations
├── model/
│   └── SSHProfile.kt            # Room entity representing a saved profile
├── security/
│   └── EncryptionHelper.kt      # AES-256-GCM encryption via Android Keystore
├── ssh/
│   ├── SshConnectionManager.kt  # JSch-based SSH session & shell channel manager
│   ├── SshConnectionListener.kt # Callback interface for connection events
│   └── SshStatus.kt             # Connection state enum
└── ui/
    ├── connection/
    │   ├── ConnectionFragment.kt    # Shell UI: profile picker, log output, send commands
    │   └── ConnectionViewModel.kt  # ViewModel for connection state
    └── profiles/
        ├── ProfileListFragment.kt   # List of saved profiles
        ├── AddEditProfileDialog.kt  # Dialog to create/edit a profile
        ├── ProfileViewModel.kt      # ViewModel for profile list
        └── SSHProfileAdapter.kt     # RecyclerView adapter
```

## Key Dependencies

| Library | Purpose |
|---|---|
| [JSch](http://www.jcraft.com/jsch/) `0.1.55` | SSH protocol implementation |
| AndroidX Room `2.5.0` | Local SQLite database |
| AndroidX Navigation `2.5.3` | Fragment navigation with Safe Args |
| AndroidX Lifecycle (ViewModel / LiveData) `2.6.2` | MVVM architecture support |
| Android Keystore (system) | Secure key storage for credential encryption |

## CI/CD

The included GitHub Actions workflow (`.github/workflows/build-release.yml`) automatically:

1. Builds the release APK on every push/PR to `main`
2. Signs the APK if the following repository secrets are configured:
   - `SIGNING_KEY_STORE_BASE64` — base64-encoded keystore file
   - `KEY_ALIAS` — key alias within the keystore
   - `KEY_STORE_PASSWORD` — keystore password
   - `KEY_PASSWORD` — key password
   - `RELEASE_PAT` — GitHub Personal Access Token with `repo` + `workflow` scopes
3. Creates a GitHub Release and uploads the signed APK

If the signing secrets are absent, the workflow still builds but skips signing and release creation.

## Security Notes

- Credentials (passwords and private keys) are never stored in plaintext; they are encrypted using AES-256-GCM with keys managed by the Android Keystore.
- The IV is stored alongside the ciphertext (as a separate column) and is unique per encryption operation.
- Keystore files (`*.jks`, `*.keystore`) are excluded from version control via `.gitignore`.

## License

See [LICENSE](LICENSE).

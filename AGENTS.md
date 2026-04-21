# Agent Instructions for SSHInjectorApp

Welcome to the SSHInjectorApp project. As an AI agent working on this repository, please adhere to the following guidelines to maintain code quality, security, and architectural integrity.

## Architecture Overview

- **Pattern**: Model-View-ViewModel (MVVM).
- **Persistence**: Room Database for SSH profiles.
- **SSH Logic**: Managed by `SshConnectionManager` using the JSch library.
- **UI**: Fragment-based UI using the Navigation Component and ViewBinding.

## Security Mandates (CRITICAL)

- **Sensitive Data**: Never store plain-text passwords or private keys in the `SSHProfile` entity or the Room database.
- **Encryption**: Always use `com.example.sshinjector.security.EncryptionHelper` to encrypt credentials before storage and decrypt them just before use in `SshConnectionManager`.
- **Keystore**: The application relies on the Android Keystore System for AES/GCM encryption.

## Coding Standards

- **Language**: Kotlin. Use modern Kotlin idioms (e.g., `apply`, `also`, `let`).
- **Concurrency**: Use Kotlin Coroutines for all background tasks. Ensure SSH connection and data streaming happen on `Dispatchers.IO`.
- **Resources**: All strings should be placed in `res/values/strings.xml`. Use theme-defined colors and styles.
- **Error Handling**: Use the `listener` pattern in `SshConnectionManager` to propagate status changes and errors to the UI layer.

## Project Structure Guidelines

- **UI**: New screens should be added as Fragments and registered in `app/src/main/res/navigation/nav_graph.xml`.
- **ViewModels**: Logic for UI interaction must reside in the respective ViewModel.
- **SSH Operations**: All SSH-related state and lifecycle should be encapsulated within `SshConnectionManager`.

## Verification Checks

Before submitting any changes, you MUST run the following checks:

1.  **Build Project**:
    ```bash
    ./gradlew assembleDebug
    ```
    Ensure the build completes successfully.
2.  **Static Analysis** (if configured):
    ```bash
    ./gradlew lint
    ```

## Tips

- When debugging SSH connections, check the JSch logs which are piped to the `SshConnectionListener`.
- Ensure `SshConnectionManager.destroy()` is called when the ViewModel is cleared to avoid memory leaks or orphaned SSH sessions.

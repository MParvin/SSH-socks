# SSHInjectorApp

SSHInjectorApp is a specialized Android application designed to manage SSH profiles and establish secure SSH shell connections. It allows users to store multiple server configurations and execute payloads or commands directly through a shell channel.

## Features

- **Profile Management**: Full CRUD (Create, Read, Update, Delete) support for SSH profiles.
- **Secure Credential Storage**: Uses the **Android KeyStore System** to encrypt and store sensitive credentials (passwords or private keys) using AES/GCM.
- **SSH Connectivity**: Robust SSH connection handling powered by the **JSch** library.
- **Interactive Shell**: Real-time shell output streaming and command execution.
- **Modern Android UI**: Built with Fragments, ViewModels, LiveData, and the Navigation Component for a smooth user experience.
- **Local Persistence**: SSH profiles are persisted locally using **Room Database**.

## Tech Stack

- **Language**: Kotlin
- **Persistence**: Room Database
- **Networking/SSH**: JSch (Java Secure Channel)
- **Architecture**: MVVM (Model-View-ViewModel)
- **UI Components**: ViewBinding, Material Design, Navigation Component
- **Security**: Android Keystore (AES/GCM)
- **Concurrency**: Kotlin Coroutines

## Project Structure

- `com.example.sshinjector.db`: Database configuration and DAOs (Room).
- `com.example.sshinjector.model`: Data models (SSHProfile).
- `com.example.sshinjector.security`: Encryption utilities for secure credential storage.
- `com.example.sshinjector.ssh`: SSH session and channel management logic.
- `com.example.sshinjector.ui`: UI layers including Fragments and ViewModels for profile management and connections.

## Setup and Installation

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    ```
2.  **Open in Android Studio**:
    Import the project as a Gradle project.
3.  **Build**:
    Run `./gradlew assembleDebug` to build the APK.
4.  **Run**:
    Deploy to an Android device or emulator with API Level 26 (Android 8.0) or higher.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

pluginManagement {
    val flutterSdkPath =
        run {
            val localPropertiesFile = settingsDir.resolve("local.properties")
            val localProperties = java.util.Properties()

            require(localPropertiesFile.exists()) {
                "Missing local.properties at: ${localPropertiesFile.absolutePath}"
            }

            localPropertiesFile.inputStream().use { localProperties.load(it) }

            val flutterSdkPath = localProperties.getProperty("flutter.sdk")
            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
            flutterSdkPath
        }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    id("com.android.application") version "8.11.1" apply false
    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
}

include(":app")

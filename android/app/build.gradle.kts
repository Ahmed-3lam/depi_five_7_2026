import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties().apply {
    require(keystorePropertiesFile.isFile) {
        "Missing android/key.properties. See ANDROID_RELEASE.md for signing setup."
    }
    keystorePropertiesFile.inputStream().use { load(it) }
}

fun signingProperty(name: String): String =
    requireNotNull(keystoreProperties.getProperty(name)?.takeIf { it.isNotBlank() }) {
        "Missing $name in android/key.properties. See ANDROID_RELEASE.md."
    }

android {
    namespace = "com.ahmedallam.depifive"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "com.ahmedallam.depifive"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = signingProperty("keyAlias")
            keyPassword = signingProperty("keyPassword")
            storeFile = rootProject.file(signingProperty("storeFile"))
            storePassword = signingProperty("storePassword")
            storeType = "JKS"
            require(storeFile!!.isFile) { "Release keystore not found: $storeFile" }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
    }
}

flutter {
    source = "../.."
}

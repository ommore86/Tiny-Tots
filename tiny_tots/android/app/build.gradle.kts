plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin") // ✅ Required for Flutter projects
    id("com.google.gms.google-services") // ✅ Firebase plugin
}

android {
    namespace = "com.example.tiny_tots"  // ✅ Keep your correct app namespace
    compileSdk = 34  // ✅ Use actual SDK version

    defaultConfig {
        applicationId = "com.example.tiny_tots"  // ✅ Package name
        minSdk = 23  // ✅ Minimum supported Android version
        targetSdk = 34  // ✅ Latest Android target
        versionCode = 1  // ✅ Set your app version
        versionName = "1.0"
    }

    ndkVersion = "28.0.13004108"  // ✅ Use the version installed on your system

    buildTypes {
        release {
            isMinifyEnabled = false  // ✅ Ensure this is false
            isShrinkResources = false // ✅ Turn off resource shrinking
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            signingConfig = signingConfigs.getByName("debug")  // ✅ Correct signing config
        }
    }


    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_19
        targetCompatibility = JavaVersion.VERSION_19
    }

    kotlinOptions {
        jvmTarget = "19"
    }
}

flutter {
    source = "../.."
}

// ✅ Ensure dependencies are included
dependencies {
    implementation("androidx.core:core-ktx:1.9.0")
    implementation("com.google.firebase:firebase-auth:22.0.0")
    implementation("com.google.firebase:firebase-firestore:24.0.0")
}
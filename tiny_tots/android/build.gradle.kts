buildscript {
    repositories {
        google() // ✅ Ensures dependencies are downloaded from Google
        mavenCentral() // ✅ Ensures dependencies are downloaded from Maven
    }

    dependencies {
        classpath("com.android.tools.build:gradle:8.1.1") // Ensure this is correct
        classpath("com.google.gms:google-services:4.3.10") // ✅ Correct placement
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
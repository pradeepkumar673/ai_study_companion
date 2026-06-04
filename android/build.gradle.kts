allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureProject = Action<Project> {
        if (extensions.findByName("android") != null) {
            val android = extensions.getByName("android")
            try {
                val getNamespace = android.javaClass.getMethod("getNamespace")
                val currentNamespace = getNamespace.invoke(android)
                if (currentNamespace == null) {
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    val generatedNamespace = (project.group?.toString()?.takeIf { it.isNotBlank() }
                        ?: "com.example.${name.replace("-", "_").replace(".", "_")}")
                    setNamespace.invoke(android, generatedNamespace)
                    logger.lifecycle("Dynamically set namespace to $generatedNamespace for project $name")
                }
            } catch (e: Exception) {
                // Ignore
            }
        }
    }
    if (state.executed) {
        configureProject.execute(this)
    } else {
        afterEvaluate {
            configureProject.execute(this)
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

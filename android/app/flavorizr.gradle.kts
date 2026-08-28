import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "br.com.rafael.gerencia_estado_injecao_dependencia.dev"
            resValue(type = "string", name = "app_name", value = "Dogão - Dev")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "br.com.rafael.gerencia_estado_injecao_dependencia.homolog"
            resValue(type = "string", name = "app_name", value = "Dogão - Homolog")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "br.com.rafael.gerencia_estado_injecao_dependencia"
            resValue(type = "string", name = "app_name", value = "Dogão")
        }
    }

    buildFeatures.resValues = true
}
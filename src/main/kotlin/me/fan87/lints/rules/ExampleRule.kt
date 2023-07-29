package me.fan87.lints.rules

import io.gitlab.arturbosch.detekt.api.*
import org.jetbrains.kotlin.psi.KtFile

class ExampleRule(config: Config = Config.empty) : Rule(config) {
    override val issue = Issue(
        "ExampleRule",
        Severity.Defect,
        "Something",
        Debt(0, 0, 1)
    )

    override fun visitCondition(root: KtFile): Boolean {
        return false
    }

}
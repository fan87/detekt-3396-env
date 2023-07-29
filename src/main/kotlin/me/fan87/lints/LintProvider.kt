package me.fan87.lints

import io.gitlab.arturbosch.detekt.api.Config
import io.gitlab.arturbosch.detekt.api.RuleSet
import io.gitlab.arturbosch.detekt.api.RuleSetProvider
import me.fan87.lints.rules.ExampleRule

class LintProvider : RuleSetProvider {
    override val ruleSetId: String = "TestingRule"

    override fun instance(config: Config): RuleSet {
        println("Hello, World!!")
//        error("HUH v2")
        error("ASDF")

        return RuleSet(ruleSetId, listOf(
            ExampleRule(config)
        ))
    }


}
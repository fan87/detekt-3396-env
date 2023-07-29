
package me.fan87.lints


class LintProvider : io.gitlab.arturbosch.detekt.api.RuleSetProvider {
    override val ruleSetId: String = "TestingRule"

    override fun instance(config: io.gitlab.arturbosch.detekt.api.Config): io.gitlab.arturbosch.detekt.api.RuleSet {
        // println("Hello, World!!")

        return io.gitlab.arturbosch.detekt.api.RuleSet(ruleSetId, listOf(
            me.fan87.lints.rules.ExampleRule(config)
        ))
    }
}


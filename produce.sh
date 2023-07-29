#!/bin/sh


java -version

echo "[i] Resetting Gradle (clean + stop)"
./gradlew --stop

./gradlew clean

echo "
package me.fan87.lints


class LintProvider : io.gitlab.arturbosch.detekt.api.RuleSetProvider {
    override val ruleSetId: String = \"TestingRule\"

    override fun instance(config: io.gitlab.arturbosch.detekt.api.Config): io.gitlab.arturbosch.detekt.api.RuleSet {
        println(\"Hello, World!!\")

        return io.gitlab.arturbosch.detekt.api.RuleSet(ruleSetId, listOf(
            me.fan87.lints.rules.ExampleRule(config)
        ))
    }
}
" > src/main/kotlin/me/fan87/lints/LintProvider.kt


echo "[i] Initializing Gradle. Expecting output \"me.fan87.lints.LintProvider@\""

if ./gradlew detekt --console=plain --rerun-tasks | grep -q "me.fan87.lints.LintProvider@"
then
  echo "[i] Work as expected"
else
  >&2 echo "[!] Test failed, didn't get \"me.fan87.lints.LintProvider@\" in the output"
fi

echo "
package me.fan87.lints


class LintProvider : io.gitlab.arturbosch.detekt.api.RuleSetProvider {
    override val ruleSetId: String = \"TestingRule\"

    override fun instance(config: io.gitlab.arturbosch.detekt.api.Config): io.gitlab.arturbosch.detekt.api.RuleSet {
        // println(\"Hello, World!!\")

        return io.gitlab.arturbosch.detekt.api.RuleSet(ruleSetId, listOf(
            me.fan87.lints.rules.ExampleRule(config)
        ))
    }
}
" > src/main/kotlin/me/fan87/lints/LintProvider.kt

set OUTPUT=$(./gradlew detekt --console=plain --rerun-tasks)
if echo $OUTPUT | grep -q "me.fan87.lints.LintProvider@"
then
  if echo $OUTPUT | grep -q "Hello, World!!"
  then
    >&2 echo "[!] Test failed, the Jar in the classpath is not updated";
  else
    echo "[i] Test has passed";
  fi
else
  echo "[i] Didn't get \"me.fan87.lints.LintProvider@\" in the output";
  echo "[i] Re-running the command with a fresh Gradle Daemon"
  if ./gradlew detekt --console=plain --rerun-tasks --no-daemon | grep -q "me.fan87.lints.LintProvider@"
  then
    >&2 echo "[!] Test failed, LintProvider was gone. With a new Gradle daemon, it's now back again."
  else
    >&2 echo "[!] Warning: Script is problematic, LintProvider has disappeared completely from registered rule sets unexpectedly"
  fi
fi

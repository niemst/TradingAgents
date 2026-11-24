#!/bin/sh
# Exit 0 only when the latest sync-upstream run of niemst/TradingAgents failed.
# Used as the precheck of the Orca automation that starts a fix agent.
GH_TOKEN=$(gh auth token -u niemst) || exit 1
export GH_TOKEN
conclusion=$(gh run list --repo niemst/TradingAgents --workflow sync-upstream.yml --branch main --limit 1 --json conclusion --jq '.[0].conclusion') || exit 1
[ "$conclusion" = "failure" ]

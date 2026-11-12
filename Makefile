.PHONY: check docs-check test
check: docs-check test

docs-check:
	@bash scripts/check-docs.sh

test:
	@bash tests/test-check-docs.sh

.PHONY: dev
dev:
	nomad agent -dev -bind 0.0.0.0 -log-level INFO

.PHONY: consul-up
consul-up:
	consul agent -dev -bind 0.0.0.0  -log-level INFO


.PHONY: run-example
run-example:
	ls -1 -d src/* | xargs -n 1 nomad job run

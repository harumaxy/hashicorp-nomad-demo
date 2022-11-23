.PHONY: dev
dev:
	nomad agent -dev -bind 0.0.0.0 -log-level INFO

.PHONY: consul-up
consul-up:
	consul agent -dev -bind 0.0.0.0  -log-level INFO


.PHONY: run-example
run-example:
	nomad job run example.nomad

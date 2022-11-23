# Memo

## Requirements

```sh
brew tap hashicorp/tap
brew install hashicorp/tap/nomad hashicorp/tap/consul
```

## task runner

task runner として `make` を使う。

Makefile にコマンドを書く => .PHONY でダミーターゲットを記述 => ダミーのビルドターゲットをサブコマンドとして使う

https://yu-nix.com/archives/makefile-phony/

nomad, consul エージェントを停止するにはキーボードからインタラプトする<br>
(デプロイしたサーバー、コンテナも消える)




## Setup

```sh
make consul-up
make dev

# まとめてallocate
ls -d src/* | xargs -n 1 nomad job run
```
# Symbol Node Builder

Building Symbol nodes is easy for everyone.

## Overview

自前ノード(VPS含む)上に、簡単にSymbolノード(peer, api)を構築するツールです。自分の環境上に、Allnodesなどのサービスでは現在実現できない、柔軟な構成・設定でSymbolノードを構築できます。以下の機能に対応しています。

- 複数ノードの一括構築
- 委任者数の上限を自由に設定可能
- 委任者のポリシー(インポータンス順 or 先着順)を自由に設定可能
- ノードの説明を自由に設定可能
- HTTPS化対応

This is a tool to easily build Symbol nodes (peer, api) on your own nodes (including VPS). You can build Symbol nodes on your own environment with flexible configurations and settings that cannot be achieved with services such as Allnodes. The following functions are supported.

- Batch construction of multiple nodes
- Delegator limit can be freely set
- Delegator policy (Importance order or First-come-first-served order) can be freely set
- Freely configurable node description
- Support for HTTPS

## Attention

- このツールはSymbolノードの構築までをサポートしています。Symbolノードの構築は10,000XYMを所持していなくても可能です。誰かがSymbolノードに委任すればノード報酬を得ることが可能です。一方で、すでに10,000XYMを保有しており、自ノードに委任したい場合は、Symbol Walletからハーベスティング設定を行ってください。

- このツールのサポートOSは **Ubuntu** です。作者は *Ubuntu 20.04* でのテストを実施しています。**CentOS系では動作しません**。(ご要望があれば今後対応するかもしれません)

- ノードの要件スペックは以下になります。このスペック未満での動作は保証しません。
  - CPU: 4コア以上
  - メモリ: 8GB以上
  - ストレージ: 500GB以上

- 本ツールの使用は自己責任とします。本ツールを使用したことによる損害などの一切の責任を作者は負いません。

--

- This tool supports until building Symbol nodes. You don't need to have 10,000XYM to build a Symbol node, and if someone delegates to your Symbol node, you can get node rewards. On the other hand, if you already have 10,000XYM and want to delegate to your own node, please set up harvesting from the Symbol Wallet.

- The supported OS for this tool is **Ubuntu**. The author has tested it on *Ubuntu 20.04* and **it does not work on CentOS systems**. (It may be supported in the future if requested).

- The following are the required specifications for the node. Operation with less than these specifications is not guaranteed.
  - CPU: 4 cores or more
  - Memory: 8GB or more
  - Storage: 500GB or more

- Use of this tool is at your own risk. The author assumes no responsibility for any damages resulting from the use of this tool.

## How to use

以下の操作は Ubuntu 上で実施してください。(The following operations should be performed on Ubuntu.)

1： ツールをダウンロードして解凍します。(Download and unzip the tool.)

  ```(text)
  $ wget https://github.com/koutyan/Symbol-Node-Builder/archive/refs/tags/v1.0.tar.gz
  $ tar xzvf Symbol-Node-Builder-1.0.tar.gz
  ```

2： **/confディレクトリ内**のファイルを編集して、自分に合った設定にします。(Edit the files **in the /conf directory** to make the settings suitable for you.)

- **inventory**：実行対象ノードのホスト名またはIPアドレスを指定します。基本的にはデフォルトの`localhost`で問題ないです。もし、現在操作しているサーバーとは他のサーバーに構築したい場合はそのサーバーのIPアドレスに置き換えてください。また、複数ノードを一括構築したい場合は、このファイルに対象サーバーのIPアドレスを改行して記載してください。(Specify the hostname or IP address of the node to be executed. Basically, the default `localhost` is fine. If you want to build on a different server than the one you are currently operating on, replace it with the IP address of that server. Also, if you want to build multiple nodes at once, please enter the IP address of the target server in this file with a new line. )

- **preset.yml**：このファイルではハーベスティングのための重要な設定を行います。`friendlyName`では、ノードの説明を自由に設定できます。`maxUnlockedAccounts`では、委任者数の上限を設定できます。ノードのスペックに応じて設定してください。`beneficiaryAddress`には、ノード報酬を振り込んで欲しいアドレスを記載してください。`delegatePrioritizationPolicy`では、委任者数が上限に達した場合にノードに残す順序を設定できます。インポータンス順(Importance)か先着順(Age)かを設定してください。(This file contains important settings for harvesting. The `friendlyName` allows you to set any description of the node. For `maxUnlockedAccounts`, you can set the maximum number of delegates. Set it according to the specifications of the node. `beneficiaryAddress` is the address to which you want the node reward to be transferred. `delegatePrioritizationPolicy` allows you to set the order in which delegates will be left on the node when the limit is reached. You can set either Importance order or Age order.)
  
    ```(text)
    nodes:
      - friendlyName: Your Symbol node description
        maxUnlockedAccounts: 20
        beneficiaryAddress: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        delegatePrioritizationPolicy: Age
    ```

- **vars.yml**：`username`に、構築するノードの一般ユーザー名を指定してください。このユーザー名はすでに存在することが前提です。また、ノードをHTTPSに対応させたくない場合は、`https_node`をfalseにしてください。`symbol_password`には、Symbolノードの設定ファイルを暗号化するためのパスワードを自由に設定してください。(The `username` should be the general user name of the node to be built. It is assumed that this user name already exists. Also, if you don't want your node to support HTTPS, set `https_node` to false. Feel free to set a password for `symbol_password` to encrypt the configuration files of Symbol nodes.)

    ```(text)
    username: ubuntu
    https_node: true
    symbol_password: hogehoge
    ```

3： 以下のコマンドを実行します。構築前の準備が行われます。"Setup done." と表示されたら成功です。(Execute the following command. Pre-build preparations are made. If you see "Setup done.", you have succeeded.)

```(text)
$ sudo chmod +x setup.sh
$ ./setup.sh
```

4： 最後に以下のコマンドを実行します。ユーザーパスワードとrootパスワードを求められるので、入力してください。Symbolノードの構築が実施されます。`WARNING`などの表示は気にしないでください。(Finally, execute the following command, then you will be prompted for your user password and root password, enter them: Symbol node construction will be performed. Don't worry about the `WARNING` and other indications.)

```(text)
$ ansible-playbook playbook.yml -vvv
```

![p01](https://kosukelab.com/share/symbol-node-builder-01.png)

5： しばらく待って、実施結果が表示され、`failed: 0` となっていれば成功です。ブロックチェーンの同期を待って、数時間後に [Symbol Node List](https://symbolnodes.org/nodes/) に反映されていることを確認してください。以上で完了です。(Wait a few minutes, if the result is `failed: 0`, you have succeeded. Wait for the blockchain to synchronize, and confirm that the result is reflected in the [Symbol Node List](https://symbolnodes.org/nodes/) in a few hours. You are done.)

## Tips

- 手順4での実行時でのパスワード入力を省略したい場合は、対象ノードと鍵交換を実施しておいてください。そのうえで、**ansible.cfg** の`ask_pass`と`become_ask_pass`の値をfalseにしてください。

    ```(text)
    [defaults]
    inventory = ./conf/inventory
    ask_pass = false           # ← これ

    [privilege_escalation]
    become = true
    become_method = sudo
    become_user = root
    become_ask_pass = false    # ← これ
    ```

- Symbolノードの構築に成功しているにもかかわらず、`:3000/node/info`に接続できない場合は、利用しているサービスのパケットフィルタリングが邪魔をしている可能性が高いです。`3000` `7900` `3001` `80` ポートが許可されているかを確認し、不足があればルールを追加してください。

    ![p02](https://kosukelab.com/share/symbol-node-builder-02.png)

- 失敗した場合は、[Issue page](https://github.com/koutyan/Symbol-Node-Builder/issues) に以下の情報を添えて投稿してください。また、すでに解決している問題の可能性も高いため、投稿する前に過去のIssueを確認してください。(なお、手順3と4を何度実行してもノードに影響を及ぼさない設計としています。)

  - 手順のどこで失敗したのか (例: 手順4で失敗した)
  - エラー内容 (長い場合はコピペして別途ファイルにペーストして添付するのが望ましい)

- その他、ご意見やご要望なども上記Issue pageにて受け付けております。

--

- If you want to omit the password input at runtime in step 4, exchange keys with the target node. Then, set the values of `ask_pass` and `become_ask_pass` in **ansible.cfg** to false.

    ```(text)
    [defaults]
    inventory = ./conf/inventory
    ask_pass = false           # ← HERE

    [privilege_escalation]
    become = true
    become_method = sudo
    become_user = root
    become_ask_pass = false    # ← HERE
    ```

- If you can't connect to `:3000/node/info` even though you have successfully built a Symbol node, it is most likely that the packet filtering of the service you are using is interfering. Check if the `3000` `7900` `3001` `80` port is allowed and add a rule if it is missing.

- If this fails, please post the issue on the [Issue page](https://github.com/koutyan/Symbol-Node-Builder/issues) with the following information. It is also likely that the problem has already been solved, so please check the previous issues before posting. (Note that the design does not affect the nodes no matter how many times steps 3 and 4 are executed.)

  - Where in the procedure did it fail (e.g., step 4 failed)
  - Details of the error (if it is long, it is preferable to copy and paste it into a separate file and attach it)

- Other comments and requests are also welcome on the above Issue page.

## Donate

- Symbol (XYM): `NCTFRL5RGOAKAW4B3HZLUMEM6YGWI3WRK4V2OKY`
- My Symbol Node: `https://001symbol.blockchain-node.tech:3001`

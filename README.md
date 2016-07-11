# setup-lb-dsr-script

## 概要

さくらのクラウド用ロードバランサでの、配下のサーバーにDSR設定を行うためのスタータップスクリプトリソースです。
  
## Variables

| 変数名        | 名称     | デフォルト値 | 説明       | 
|--------------|----------|---------|---------------|
|name          | 名称      | `note`    | - |
|vip           | VIP      | -            | (必須)ロードバランサーに登録したVIP |
  
## Output

| 変数名           | 名称       | 説明       | 
|-----------------|------------|------------|
|note_id          | ID         |  スタートアップスクリプトのID |
|note_content     | コンテンツ   |  スタートアップスクリプトのコンテンツ |

## Example

```main.if:サンプル
# LoadBalancer用サーバー設定(DSR)スクリプト
module "lb_dsr_script" {
    source = "github.com/terraform-for-sakuracloud-modules/setup-lb-dsr-script"
    vip = "192.168.11.1"
}

# インストール元アーカイブ
data "sakuracloud_archive" "centos" {
    filter = {
        name = "Name"
        values = ["CentOS 7.2 64bit"]
    }
}

# ディスク(CentOSベース)
resource "sakuracloud_disk" "disk01" {
    name = "disk01"
    source_archive_id = "${data.sakuracloud_archive.centos.id}"
    note_ids = ["${module.lb_dsr_script.note_id}"]
}

# サーバー
resource sakuracloud_server "server01" {
    name = "server01"
    disks = ["${sakuracloud_disk.disk01.id}"]
}

```

## License

  This project is published under [Apache 2.0 License](LICENSE).

## Author

  * Kazumichi Yamamoto ([@yamamoto-febc](https://github.com/yamamoto-febc))

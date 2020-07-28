provider "heroku" {

}

# とりあえず作成してみるだけ。
# 今はサービスが無いのでテスト用に。
resource "heroku_app" "slot_sns_app" {
    name = "slot-sns-app"
    region = "us"
}

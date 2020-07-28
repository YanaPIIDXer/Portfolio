provider "heroku" {

}

# Database
resource "heroku_app" "slotsns_database" {
    name = "SlotSNS-Database"
    region = "US"
}
